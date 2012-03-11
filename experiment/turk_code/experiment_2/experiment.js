var trial = 0;
var premise = 0;
var trialId = -1;

// 0 for intro, 1 for instructions, 2 for things, 3 for thank you
var state = 0;

var subjectId = -1;

var result = '';

// var condition = Math.random() > .5;
var condition = true;  // going all natural for this round
var conditionClass = '';
var catchPassed = true;

function randInt(min, max){
    // should be inclusive on both sides
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

var catchStimuli = [{"trial": -1, "isCatch": 2, "phrase": "Please select 2"},
		    {"trial": -2, "isCatch": 6, "phrase": "Please select 6"}
		    ];

var stimSet = randInt(0, stimuliSets.length - 1);
var stimuli = stimuliSets[stimSet].concat(catchStimuli);

var results = {};

function stepExperiment(e){
    switch(state){
    case 0:  // intro landing page
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
    case 1:  // instruction page
	state = 2;
	$('.panel').hide();
	$('.phrase').html(stimuli[trial].phrase);
	$('.panel[panel="phrase"]').show();
	break;
    case 2:  // stimuli
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
    case 3: // survey: nothing to be done here!
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

	results.stimuli = stimSet;
	
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

