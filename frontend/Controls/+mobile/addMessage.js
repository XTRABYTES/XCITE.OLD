WorkerScript.onMessage = function(message) {
    var notAllowed = ["<del>","</del>","<s>","</s>","<strong>","</strong>", "<br>","<p>","</p>","</font>","<h1>","</h1>","<h2>","</h2>","<h3>","</h3>","<h4>","</h4>","<h5>","</h5>","<h6>","</h6>","a href=","img src=","ol type=","ul type=","<li>","</li>","<pre>","</pre>","&gt","&lt","&amp"]
    var xChatTag = 0
    var xChatMessage = message.msg

    for(var o = 0; o < notAllowed.length; o ++) {
        var u = new RegExp( notAllowed[o], "gi")
        xChatMessage = xChatMessage.replace(u, "")
    }

    var messageArray = xChatMessage.split(' ')
    var username = "@" + message.me

    if(message.author !== message.me && message.dnd === false) {
        for(var i = 0; i < (messageArray.length); i ++) {
            var e = messageArray[i]
            if ((e === username || e === "<b>" + username || e === username + "</b>" || e === "<b>" + username + "</b>")  && message.tagMe === true) {
                xChatTag = 1
            }
            else if ((e === "@everyone" || e === "<b>@everyone" || e === "@everyone</b>" || e === "<b>@everyone/b>")  && message.tagEveryone === true) {
                if (xChatTag !== 1) {
                    xChatTag = 2
                }
            }
        }

    }
    console.log("link: " + message.link + ", image: " + message.image + ", quote: " + message.quote)
    var searchUsername = new RegExp( "@" + message.me, "gi")
    var searchEveryone = new RegExp("@everyone", "gi")
    xChatMessage = xChatMessage.replace(searchUsername, "<font color='#0ED8D2'><b>@" + message.me + "</b></font>")
    xChatMessage = xChatMessage.replace(searchEveryone, "<font color='#5E8BFF'><b>@everyone</b></font>")
    WorkerScript.sendMessage({ "author": message.author, "date": message.date, "time": message.time, "device": message.device, "msg": xChatMessage, "tag": xChatTag, "link": message.link, "image": message.image, "quote": message.quote, "msgID": message.msgID})
}
