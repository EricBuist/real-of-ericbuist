/*
 * AntiSpamMailTo
 * Jean-Francois Gagne
 * http://www.iro.umontreal.ca/~gagnjea/
 */

function AntiSpamMailTo(email, start, jump) {
  var i;
  var newemail = "";

  for(i = 0; i < email.length; i++) {
    newemail += email.charAt(start);
    start += jump;
    start = start % email.length;
  } 
 
  return "<a href=\"mailto:Eric Buist &lt;" + newemail + "&gt;\">" + newemail + "</a>";
}
