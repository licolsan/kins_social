function create_send_message() {
	App.messages = App.cable.subscriptions.create(
		{ channel: "MessagesChannel", channel_id: $("#channel_id").val() },
		{
		  connected: function() {},
		  disconnected: function() {},
		  received: function(data) {
		  	$("#message_content").val("");
		  	return $("#messages").append(this.render_message(data));
		  },
		  render_message: function(data) {
		  	return "<p><strong>" + data.user +": </strong>" + data.message +"</p>";
		  }
	  }
  );
  return App.messages;
}