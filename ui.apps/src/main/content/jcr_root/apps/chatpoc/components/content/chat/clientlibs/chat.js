function sendMessage(key, userType) {
	var newMessage = $("#" + userType + "_" + key).val();
	alert("new message is " + newMessage);
	var newMessageTime = $.now();
	$.ajax({
		url: "/content/chatqueue/data/" + key + "/messages/" + newMessageTime,
		type: "POST",
		data: {
			message: newMessage,
			serviceOwner: currentUser,
			user: userType
		},
		success: function(result, status) {
			alert(status);
			console.log("the status is " + status);
			$("#" + userType + "_" + key).val("");
		},
		error: function(result) {
			console.log("error");
		}
	});
}

function getMessages(key, userType) {
	console.log("----------------------------inside get messgaes");
	setInterval(function() {
		var allMessages = "";
		$.ajax({
			url: "/content/chatqueue/data/" + key + "/messages.1.json",
			type: "GET",
			success: function(result, status) {
				$("#" + userType + "ChatMessages").empty();
				$.each(result, function(key, val) {
					if (val.message != null) {
						allMessages = allMessages + val.message + "</br>";
					}
				});
				$("#" + userType + "ChatMessages").html(allMessages);
			},
			error: function(result) {
				console.log("error");
			}
		});
	}, 1000);
}