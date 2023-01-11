
$(function(){
	let name = new URLSearchParams(location.search).get('name');
	productReply.list(name);
})
