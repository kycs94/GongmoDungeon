$(".menu .openmenu").click(function(){
	var submenu = $(this).next("ul");
        console.log(submenu);
        if( submenu.is(":visible") ){
            submenu.slideUp();
        }else{
            submenu.slideDown();
        }
});

$(".allmenu .cMenu").click(function(){
	$(".allmenu").find(".cMenu").removeClass('active');
	$(this).addClass('active');
});

function changeWrite(){
	var writeSelect = document.getElementById("commuWrite");
	var selectValue = writeSelect.options[writeSelect.selectedIndex].value;
	if(selectValue == "review"){
		window.location = "communityReviewWriteForm.jsp";
	}else if(selectValue == "free"){
		window.location = "communityWriteForm.jsp";
	}

}

$(".openCommBtn").click(function(){
	var parent = $(this).parents("tr");
	var commcomm = $(parent).next();
	var allComm = $(".closeComm").click();
	console.log(commcomm);
	$(commcomm).addClass('vdtToggle');
	$(".commentfocus").focus();
});

$(".closeComm").click(function(){
	var parent = $(this).parents("tr");
	$(parent).find(".commentfocus").val("");
	$(parent).removeClass('vdtToggle');
});

