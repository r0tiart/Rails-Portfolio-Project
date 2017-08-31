$( document ).ready(function() {
	selectAuthor()
	newAuthor()
});


function selectAuthor(){
	$(".select-author").on("click", function(e){
		e.preventDefault()
		alert("i've been clicked")
	})
}

function newAuthor(){
	$(".new-author").on("click", function(e){
		e.preventDefault()
		alert("i've been clicked")
	})
}