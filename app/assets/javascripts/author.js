$( document ).ready(function() {
	
	selectAuthor()
	newAuthor()
});


function selectAuthor(){
	$(".select-author").on("click", function(e){
		e.preventDefault()
		$(".field-author").show()
		$(".field-newAuthor").hide()

	})
}

function newAuthor(){
	$(".new-author").on("click", function(e){
		e.preventDefault()
		$(".field-newAuthor").show()
		$(".field-author").hide()

	})
}