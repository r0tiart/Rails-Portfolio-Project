$( document ).ready(function() {
    $(".userBooks").on("click", function(e) {
      e.preventDefault()
      alert("hijacked!")
    })

});