import java.util.*;
import java.io.*;

import edu.stanford.nlp.objectbank.TokenizerFactory;
import edu.stanford.nlp.process.CoreLabelTokenFactory;
import edu.stanford.nlp.process.DocumentPreprocessor;
import edu.stanford.nlp.process.PTBTokenizer;
import edu.stanford.nlp.ling.CoreLabel;
import edu.stanford.nlp.ling.HasWord;
import edu.stanford.nlp.trees.*;
import edu.stanford.nlp.parser.lexparser.LexicalizedParser;
import edu.stanford.nlp.process.DocumentPreprocessor.DocType;
import edu.stanford.nlp.trees.TypedDependency;

public class MyParser{

    public static void main(String[] args) throws Exception{
	String filename = args[0];

	int adjCount = 0;
	int advCount = 0;
	HashMap<String, Integer> adjIndex = new HashMap<String, Integer>();
	HashMap<String, Integer> advIndex = new HashMap<String, Integer>();
	Scanner sc = new Scanner(new File("adjectives.txt"));
	while(sc.hasNextLine()){
	    String adj = sc.nextLine();
	    adjIndex.put(adj, adjCount);
	    adjCount++;
	}
	sc.close();
	sc = new Scanner(new File("modifiers.txt"));
	while(sc.hasNextLine()){
	    String adv = sc.nextLine();
	    advIndex.put(adv, advCount);
	    advCount++;
	}
	sc.close();

	int[][] depCounts = new int[adjCount][adjCount];
	int[][] bigramCounts = new int[adjCount][adjCount];

	BufferedWriter bigramOut = new BufferedWriter(new FileWriter("results/" + filename + "_bigrams.txt"));
	BufferedWriter depOut = new BufferedWriter(new FileWriter("results/" + filename + "_dep.txt"));
	BufferedWriter adjUnigramOut = new BufferedWriter(new FileWriter("results/" + filename + "_adj_unigram.txt"));
	BufferedWriter advUnigramOut = new BufferedWriter(new FileWriter("results/" + filename + "_mod_unigram.txt"));
	BufferedWriter sentenceOut = new BufferedWriter(new FileWriter("results/" + filename + "_sentences.txt"));

	LexicalizedParser lp = new LexicalizedParser("grammar/englishPCFG.ser.gz");
	TreebankLanguagePack tlp = new PennTreebankLanguagePack();
	GrammaticalStructureFactory gsf = tlp.grammaticalStructureFactory();
	// You could also create a tokenier here (as below) and pass it
	// to DocumentPreprocessor
	for (List<HasWord> sentence : new DocumentPreprocessor("mydata/" + filename, DocType.XML)) {
	    boolean bigramFound = false;
	    boolean dependencyFound = false;

	    String prev = "";
	    for(HasWord hasWord: sentence){
		String word = hasWord.word();
		if(adjIndex.containsKey(word)){
		    adjUnigramOut.write(word + "\n");
		    adjUnigramOut.flush();
		    if(advIndex.containsKey(prev)){
			bigramCounts[adjIndex.get(word)][advIndex.get(prev)]++;
			bigramOut.write(prev + " " + word + "\n");
			bigramOut.flush();
			bigramFound = true;
		    }
		}
		if(advIndex.containsKey(word)){
		    advUnigramOut.write(word + "\n");
		    advUnigramOut.flush();
		}
		prev = word;
	    }

	    try {
		Tree parse = lp.apply(sentence);
		GrammaticalStructure gs = gsf.newGrammaticalStructure(parse);
		Collection<TypedDependency> tdl = gs.typedDependenciesCCprocessed(true);
		for(TypedDependency td: tdl){
		    String head = td.gov().toString("word");
		    String dep = td.dep().toString("word");
		    if(advIndex.containsKey(dep) && adjIndex.containsKey(head)){
			depCounts[adjIndex.get(head)][advIndex.get(dep)]++;
			depOut.write(dep + " " + head + "\n");
			depOut.flush();
			dependencyFound = true;
		    }
		}
	    }catch(OutOfMemoryError e){
		System.out.println("Out of Memory Error");
	    }
	    lp.reset();

	    if(bigramFound || dependencyFound){
		sentenceOut.write(sentence + "\n");
		if(bigramFound) sentenceOut.write("bigram ");
		if(dependencyFound) sentenceOut.write("dependency");
		sentenceOut.write("\n");
		sentenceOut.flush();
	    }
	}
	bigramOut.close();
	depOut.close();
	sentenceOut.close();
	advUnigramOut.close();
	adjUnigramOut.close();

	BufferedWriter out = new BufferedWriter(new FileWriter("results/" + filename + "_bigram_matrix.txt"));
	for(int i = 0; i < adjCount; i++){
	    for(int j = 0; j < advCount; j++){
		out.write(bigramCounts[i][j] + ",");
	    }
	    out.write("\n");
	}
	out.close();
	out = new BufferedWriter(new FileWriter("results/" + filename + "_dep_matrix.txt"));
	for(int i = 0; i < adjCount; i++){
	    for(int j = 0; j < advCount; j++){
		out.write(depCounts[i][j] + ",");
	    }
	    out.write("\n");
	}
	out.close();

    }

    private MyParser(){}
}
