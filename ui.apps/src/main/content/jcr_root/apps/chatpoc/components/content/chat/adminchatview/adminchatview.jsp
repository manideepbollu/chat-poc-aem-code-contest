<%--

  Admin Chat Component component.

  

--%><%
%><%@include file="/libs/foundation/global.jsp"%><%
%><%@page session="false" %><%
%><%
	// TODO add you code here
%>
<cq:includeClientLib categories="cq.jquery"/>
<h3>List of Chat Queue </h3><br>
<div id="queueList">There is no queue right now</div>
<div id="adminChatBox"></div>
<div id="customerRepChatMessages"></div>

<script type="text/javascript">
var currentUser;
$( document ).ready(function() {
    console.log( "ready!" );
    currentUser = CQ_Analytics.ClientContextMgr.getId();
    console.log("current user:::::::"+currentUser);
    setInterval(function(){
        getchatRequests();
    }, 1000);
});

     function getchatRequests(){
        $.ajax({
            url: "/content/chatqueue.infinity.json",
            type: "GET",
            success: function(result){
                console.log(result.data);
                $("#queueList").empty();
                $.each( result.data, function( key, val ) {
                    console.log(val.isNewRequest);
                    if(val.isNewRequest == "true"){
                        $("#queueList").append("UserName :"+val['jcr:createdBy']+"<br>Query is"+val.queryFor+"<br><button onclick='acceptChat("+key+")'>Accept Chat</button><br><br>");
                    }
                });
            },
            error:function(result){
                console.log("error");
            }
        });  
   }

    function acceptChat(key){ 
        alert("hi:: "+key);
        var userType = '"customerRep"';
        $.ajax({
            url: "/content/chatqueue/data/"+key,
            type: "POST",
            data: {isNewRequest: "false", serviceOwner:currentUser},
            success: function(result,status){
            	alert(status);
                console.log("the status is "+status);
                if(status == "success"){
                    $("#adminChatBox").html("<input id= customerRep_"+key+" type='text' name='message'/><button onclick='sendMessage("+key+","+userType+")'>Send</button>");
                    getMessages(key,userType.replace(/\"/g, ""));
                }

            },
            error:function(result){
                console.log("error");
            }
        });  
   	}

</script>