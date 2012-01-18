// import some libraries:
import java.io.*; 
import java.util.*; 
import edu.stanford.nlp.trees.*; 
import edu.stanford.nlp.process.*;
import edu.stanford.nlp.objectbank.TokenizerFactory;
import edu.stanford.nlp.parser.lexparser.LexicalizedParser;

class myParser // start of the myParser class
{
	public static void main(String[] args) // start of the main method
	{
		System.out.println("\n\n\nSTART\n\n\n"); // print START
		try // device to handle potential errors
		{
			// open file whose path is passed
			// as the first argument of the main method:
			FileInputStream fis = new FileInputStream(args[0]); 
			DataInputStream dis = new DataInputStream(fis);
			BufferedReader br = new BufferedReader(new InputStreamReader(dis));
			
			// prepare Parser, Tokenizer and Tree printer:
			LexicalizedParser lp = new LexicalizedParser("englishPCFG.ser.gz"); 
			TokenizerFactory tf = PTBTokenizer.factory(false, new WordTokenFactory());
			TreePrint tp = new TreePrint("penn,typedDependenciesCollapsed");
			
			String sentence; // initialization
			// for each line of the file
			// retrieve it as a string called 'sentence':
			while ((sentence = br.readLine()) != null)   
			{ 
				// print sentence:
				System.out.println ("\n\n\n\nORIGINAL:\n\n" + sentence); 
				// put tokens in a list:
				List tokens = tf.getTokenizer(new StringReader(sentence)).tokenize(); 
				lp.parse(tokens); // parse the tokens
				Tree t = lp.getBestParse(); // get the best parse tree
				System.out.println("\nPROCESSED:\n\n"); tp.printTree(t); // print tree
			} 
			dis.close(); // close input file
		} 
		catch (Exception e) // catch error if any
		{ 
			System.err.println("ERROR: " + e.getMessage()); // print error message
		}
		System.out.println("\n\n\nTHE END\n\n\n"); // print THE END
	} // end of the main method
} // end of the myParser class