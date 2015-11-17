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


<script type="text/javascript">

    console.log(CQ_Analytics.ClientContextMgr.getId());
    var currentUser = CQ_Analytics.ClientContextMgr.getId();
    $("#chatButton").click(function() {
      	alert( "Handler for .click() called." );
        var newChat = $.now();
        var query= $("#primaryQuery").val();
        alert(query)
        $.ajax({
            url: "/content/chatqueue/data/"+newChat,
            type: "POST",
            data: {isNewRequest: "true", queryFor: query, user:currentUser},
            success: function(result){
            	$("#div1").html(result);
        	},
            error:function(result){
            	$("#div1").html(result);
        	}
        });

    });

</script>