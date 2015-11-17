<%--

  Admin Chat Component component.

  

--%><%
%><%@include file="/libs/foundation/global.jsp"%><%
%><%@page session="false" %><%
%><%
	// TODO add you code here
%>

<h3>List of Chat Queue </h3><br>

<div id="queueList">There is no queue right now</div>

<script type="text/javascript">

$( document ).ready(function() {
    console.log( "ready!" );
    setInterval(function(){ 
        getchatRequests();
	}, 1000);
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
                        $("#queueList").append("UserName :"+val['jcr:createdBy']+"<br>Query is"+val.queryFor+" <form action = '/content/chatqueue/data/"+key+"' method='POST'><input type='hidden' name='isNewRequest' value='false'/><input type='hidden' name='serviceOwner' value='test'/><input type='submit' value='Accept'/></form>");
                    }
                });
            },
            error:function(result){
                console.log("error");
            }
        });
    }
});

</script>