var trial = 0;
var premise = 0;
var trialId = -1;

// 0 for intro, 1 for instructions, 2 for things, 3 for thank you
var state = 0;

var subjectId = -1;
var debug=false;

var result = '';

var condition = Math.random() > .5;
var conditionClass = '';
var catchPassed = true;

function randInt(min, max){
    return Math.floor(Math.random() * ((max-min) + 1)) + min;
}

function randPermutation(array){
    for(i = 0; i < array.length; i++){
	var temp = randInt(i, array.length - 1);
	var tempVal = array[i];
	array[i] = array[temp];
	array[temp] = tempVal;
    }
}

var stimuli = [
{"trial": 0, "isCatch": 0, "phrase": "slightly private"}, // -3.07838002608
{"trial": 1, "isCatch": 0, "phrase": "highly present"}, // -2.45027490084
{"trial": 2, "isCatch": 0, "phrase": "purely effective"}, // -5.39134128637
{"trial": 3, "isCatch": 0, "phrase": "pretty economic"}, // -4.59188049934
{"trial": 4, "isCatch": 0, "phrase": "half different"}, // -4.41600054448
{"trial": 5, "isCatch": 0, "phrase": "fully extra"}, // -4.80605729033
{"trial": 6, "isCatch": 0, "phrase": "entirely short"}, // -3.55124738157
{"trial": 7, "isCatch": 0, "phrase": "entirely early"}, // -4.06804286298
{"trial": 8, "isCatch": 0, "phrase": "about obvious"}, // -3.20391446817
{"trial": 9, "isCatch": 0, "phrase": "pretty popular"}, // -3.05415840689
{"trial": 10, "isCatch": 0, "phrase": "almost major"}, // -4.5744619656
{"trial": 11, "isCatch": 0, "phrase": "extremely current"}, // -2.57855008933
{"trial": 12, "isCatch": 0, "phrase": "completely special"}, // -3.70334304627
{"trial": 13, "isCatch": 0, "phrase": "half simple"}, // -2.44313514724
{"trial": 14, "isCatch": 0, "phrase": "highly top"}, // -3.91509604398
{"trial": 15, "isCatch": 0, "phrase": "fully industrial"}, // -1.663333504
{"trial": 16, "isCatch": 0, "phrase": "hardly short"}, // -1.60742931921
{"trial": 17, "isCatch": 0, "phrase": "extremely blue"}, // -1.93520538919
{"trial": 18, "isCatch": 0, "phrase": "incredibly normal"}, // -1.82518135112
{"trial": 19, "isCatch": 0, "phrase": "mostly appropriate"}, // -1.56536829641
{"trial": 20, "isCatch": 0, "phrase": "absolutely dark"}, // -1.47550658213
{"trial": 21, "isCatch": 0, "phrase": "exactly high"}, // -1.43808466833
{"trial": 22, "isCatch": 0, "phrase": "hardly close"}, // -1.56052010443
{"trial": 23, "isCatch": 0, "phrase": "slightly bad"}, // -1.5779575661
{"trial": 24, "isCatch": 0, "phrase": "rather common"}, // -1.34623930115
{"trial": 25, "isCatch": 0, "phrase": "extremely original"}, // -1.52406091682
{"trial": 26, "isCatch": 0, "phrase": "really real"}, // -1.18667777156
{"trial": 27, "isCatch": 0, "phrase": "precisely young"}, // -1.84341341127
{"trial": 28, "isCatch": 0, "phrase": "hardly poor"}, // -1.83993715426
{"trial": 29, "isCatch": 0, "phrase": "slightly only"}, // -1.34722601655
{"trial": 30, "isCatch": 0, "phrase": "partially private"}, // -0.371940328244
{"trial": 31, "isCatch": 0, "phrase": "how essential"}, // -0.448374009946
{"trial": 32, "isCatch": 0, "phrase": "how appropriate"}, // -0.768545959175
{"trial": 33, "isCatch": 0, "phrase": "totally public"}, // -0.0723173292755
{"trial": 34, "isCatch": 0, "phrase": "utterly left"}, // -0.901310508308
{"trial": 35, "isCatch": 0, "phrase": "completely individual"}, // -0.352919293037
{"trial": 36, "isCatch": 0, "phrase": "extremely interesting"}, // -0.170399729963
{"trial": 37, "isCatch": 0, "phrase": "entirely aware"}, // -0.526520587769
{"trial": 38, "isCatch": 0, "phrase": "rather fine"}, // -0.196017357369
{"trial": 39, "isCatch": 0, "phrase": "totally clear"}, // -0.139920047067
{"trial": 40, "isCatch": 0, "phrase": "enormously modern"}, // 0.0
{"trial": 41, "isCatch": 0, "phrase": "partially far"}, // 0.0
{"trial": 42, "isCatch": 0, "phrase": "halfway considerable"}, // 0.0
{"trial": 43, "isCatch": 0, "phrase": "absolutely financial"}, // 0.0
{"trial": 44, "isCatch": 0, "phrase": "enormously legal"}, // 0.0
{"trial": 45, "isCatch": 0, "phrase": "positively popular"}, // 0.0
{"trial": 46, "isCatch": 0, "phrase": "positively individual"}, // 0.0
{"trial": 47, "isCatch": 0, "phrase": "barely individual"}, // 0.0
{"trial": 48, "isCatch": 0, "phrase": "approximately little"}, // 0.0
{"trial": 49, "isCatch": 0, "phrase": "enormously cold"}, // 0.0
{"trial": 50, "isCatch": 0, "phrase": "how central"}, // 0.0391543720976
{"trial": 51, "isCatch": 0, "phrase": "about green"}, // 0.14338631991
{"trial": 52, "isCatch": 0, "phrase": "really happy"}, // 0.569935481163
{"trial": 53, "isCatch": 0, "phrase": "incredibly short"}, // 0.486630125336
{"trial": 54, "isCatch": 0, "phrase": "rather basic"}, // 0.0120544101441
{"trial": 55, "isCatch": 0, "phrase": "almost only"}, // 0.64011733977
{"trial": 56, "isCatch": 0, "phrase": "rather difficult"}, // 0.764324056274
{"trial": 57, "isCatch": 0, "phrase": "mostly present"}, // 0.0156773754148
{"trial": 58, "isCatch": 0, "phrase": "mostly civil"}, // 0.235807635692
{"trial": 59, "isCatch": 0, "phrase": "entirely black"}, // 0.196055695226
{"trial": 60, "isCatch": 0, "phrase": "purely industrial"}, // 1.53109552941
{"trial": 61, "isCatch": 0, "phrase": "purely traditional"}, // 1.04232561618
{"trial": 62, "isCatch": 0, "phrase": "perfectly whole"}, // 1.69309910432
{"trial": 63, "isCatch": 0, "phrase": "barely past"}, // 1.52751465752
{"trial": 64, "isCatch": 0, "phrase": "about foreign"}, // 1.58936902955
{"trial": 65, "isCatch": 0, "phrase": "somewhat useful"}, // 1.57843062678
{"trial": 66, "isCatch": 0, "phrase": "half only"}, // 1.1992356145
{"trial": 67, "isCatch": 0, "phrase": "absolutely beautiful"}, // 1.6996930501
{"trial": 68, "isCatch": 0, "phrase": "absolutely clear"}, // 1.28754282384
{"trial": 69, "isCatch": 0, "phrase": "incredibly easy"}, // 1.68893658424
{"trial": 70, "isCatch": 0, "phrase": "perfectly natural"}, // 2.14048841093
{"trial": 71, "isCatch": 0, "phrase": "thoroughly professional"}, // 2.50485596819
{"trial": 72, "isCatch": 0, "phrase": "almost full"}, // 2.15200362076
{"trial": 73, "isCatch": 0, "phrase": "purely local"}, // 2.52725758641
{"trial": 74, "isCatch": 0, "phrase": "completely independent"}, // 2.77618158931
{"trial": 75, "isCatch": 0, "phrase": "exactly sure"}, // 2.99827739998
{"trial": 76, "isCatch": 0, "phrase": "mostly due"}, // 2.68302316995
{"trial": 77, "isCatch": 0, "phrase": "highly successful"}, // 2.15002880432
{"trial": 78, "isCatch": 0, "phrase": "entirely different"}, // 2.33115563928
{"trial": 79, "isCatch": 0, "phrase": "entirely independent"}, // 2.12243708361
{"trial": 80, "isCatch": 0, "phrase": "halfway full"}, // 2.18555566402
{"trial": 81, "isCatch": 0, "phrase": "purely social"}, // 2.45361639606
{"trial": 82, "isCatch": 0, "phrase": "right single"}, // 2.09651658862
{"trial": 83, "isCatch": 0, "phrase": "mostly white"}, // 2.07278606068
{"trial": 84, "isCatch": 0, "phrase": "really only"}, // 2.3081994057
{"trial": 85, "isCatch": 0, "phrase": "purely physical"}, // 3.99940535724
{"trial": 86, "isCatch": 0, "phrase": "entirely responsible"}, // 3.02256962261
{"trial": 87, "isCatch": 0, "phrase": "purely political"}, // 3.48976533001
{"trial": 88, "isCatch": 0, "phrase": "perfectly fine"}, // 3.10370479373
{"trial": 89, "isCatch": 0, "phrase": "slightly different"}, // 3.1982379955
{"trial": 90, "isCatch": 0, "phrase": "totally free"}, // 3.20290318796
{"trial": 91, "isCatch": 0, "phrase": "hardly able"}, // 3.76091918507
{"trial": 92, "isCatch": 0, "phrase": "wholly responsible"}, // 3.42217811546
{"trial": 93, "isCatch": 0, "phrase": "perfectly normal"}, // 3.67065529898
{"trial": 94, "isCatch": 0, "phrase": "partially responsible"}, // 3.9245726951
{"trial": 95, "isCatch": 0, "phrase": "exactly right"}, // 3.12903066015
{"trial": 96, "isCatch": 0, "phrase": "approximately normal"}, // 3.04072550119
{"trial": 97, "isCatch": 0, "phrase": "half legal"}, // 3.02196353748
{"trial": 98, "isCatch": 0, "phrase": "absolutely free"}, // 3.39921021787
{"trial": 99, "isCatch": 0, "phrase": "mostly clear"}, // 3.54175972211
{"trial": 100, "isCatch": 2, "phrase": "Please select 2"},
{"trial": 101, "isCatch": 6, "phrase": "Please select 6"}
	       ]

var results = {};

function stepExperiment(e){
    switch(state){
    case 0:
	if (turk.previewMode) {
	    $('.panel[panel="intro"] #mustaccept').show();
	} else {
	    state = 1;
	    $('.panel').hide();
	    $('.progress').show();
	    $('.bar').show();
	    $('.panel[panel="instructions"]').show();
	}
	break;
    case 1:
	state = 2;
	$('.panel').hide();
	$('.phrase').html(stimuli[trial].phrase);
	$('.panel[panel="phrase"]').show();
	break;
    case 2:
	var response = $('input:radio[name=rating]:checked').val();
	if(response == null){
	    $('[.panel[panel="phrase"] .message').html('Please select a rating to continue');
	}else{
	    catchPassed = catchPassed && (stimuli[trial].isCatch==0 || stimuli[trial].isCatch==parseInt(response));
	    results[stimuli[trial].trial] = response;
	    trial++;
	    $('.rating').attr('checked', false);
	    $('[.panel[panel="phrase"] .message').html('');
	    $('.bar').css('width', (200.0 * trial / stimuli.length) + 'px');
	    if(trial == stimuli.length){
		$('.panel').hide();
		$('.panel[panel="survey"]').show();
		state = 3;
	    }else{
		$('.panel').hide();
		$('.phrase').html(stimuli[trial].phrase);
		$('.panel[panel="phrase"]').show();
	    }
	}
	break;
    }
}


function getQueryParams(qs) {
    qs = qs.split("+").join(" ");
    var params = {},
        tokens,
        re = /[?&]?([^=]+)=([^&]*)/g;
    while (tokens = re.exec(qs)) {
        params[decodeURIComponent(tokens[1])]
            = decodeURIComponent(tokens[2]);
    }
    return params;
}

var GET = getQueryParams(document.location.search);

$(document).ready(function(){
    if('condition' in GET){
	if(GET['condition'] == 'natural'){
	    condition = true;
	}
	if(GET['condition'] == 'grammatical'){
	    condition = false;
	}
    }

	if(condition){
		$('.natural').show();
		results.condition = 'natural';
	}else{
		$('.grammatical').show();
		results.condition = 'grammatical';
	}
    debug = 'debug' in GET && GET['debug'] == '1';

    $('.panel[panel="intro"]').show();
    $('.panel[panel="intro"] #mustaccept').hide();
    $('.progress').hide();
    $('.bar').hide();
    randPermutation(stimuli);

    $('.next').click(stepExperiment);

    $('.surveydone').click(function(){
	if(!$('.age:checked').val() || !$('.sex:checked').val()){
	    $('#surveyform .message').html('Please respond to the questions above before continuing');
	} else {
		results.catchPassed = catchPassed;
	    results.sex = $('.sex:checked').val();
	    results.age = $('.age:checked').val();
	    results.comments = $('.comments').val();
	    $('.panel').hide();
	    $('.panel[panel="thankyou"]').show();
	    turk.submit(results);
	}
    });
});

