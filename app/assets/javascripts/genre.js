$( document ).ready(function() {

	selectGenre()
	newGenre()
});


function selectGenre(){
	$(".select-genre").on("click", function(e){
		$(".field-genre").show()
		$(".field-newGenre").hide()

	})
}

function newGenre(){
	$(".new-genre").on("click", function(e){
		$(".field-newGenre").show()
		$(".field-genre").hide()

	})
}