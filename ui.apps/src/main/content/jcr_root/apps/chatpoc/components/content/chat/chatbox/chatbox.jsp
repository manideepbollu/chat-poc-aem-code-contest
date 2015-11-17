<%--

  Chat Box component.

  

--%><%
%><%@include file="/libs/foundation/global.jsp"%><%
%><%@page import="javax.jcr.*" %><%
%><%
	// TODO add you code here
%>
<h3>Chat Box </h3>
<p>Provide your query and click on chat</p>
<input id="primaryQuery" type="text" name="primaryQuery"/><br><br>
<input id="chatButton" type="button" value="click here to Chat"/><br>
<div id="div1"></div>

<script type="text/javascript">

    console.log(CQ_Analytics.ClientContextMgr.getId());
    var currentUser = CQ_Analytics.ClientContextMgr.getId();
    var isNewRequest = true;
    $("#chatButton").click(function() {
      	alert( "Handler for .click() called." );
        var newChat = $.now();
        var query= $("#primaryQuery").val();
        $.ajax({
            url: "/content/chatqueue/data/"+newChat,
            type: "POST",
            async: false,
            data: {isNewRequest: "true", queryFor: query, user:currentUser},
            success: function(result){
            	$("#div1").html("waiting..to connect");
            	var timerId = setInterval(function(){
                    checkStatus(newChat);
                    if(isNewRequest == false){
                        clearInterval(timerId);
                        console.log("your chat request has been accepted ");
            			$("#div1").html("your chat request has been accepted");
                    }
                }, 1000);
        	},
            error:function(result){
            	$("#div1").html(result);
        	}
        });

    });

    function checkStatus(newChat){
        var chatId = newChat;
        $.ajax({
            url: "/content/chatqueue/data/"+chatId+".json",
            type: "GET",
            success: function(result){
            	console.log("inside check status");
                if(result.isNewRequest != "true"){
            		isNewRequest = false;
        		}
        	},
            error:function(result){
            	console.log("something went wrong");
        	}
        });
    }

</script>