email
userLevelFiltering
	"https://secureus84.sgcpanel.com:2083/{token}/frontend/Crystal/mail/filters/managefilters.html"
	
	self shouldBeImplemented.
	
	"Results of creating group email address (method per https://secure.web-hosting.net.my/clients/knowledgebase/209/how-to-create-an-email-group-in-cpanel.html):"
	
	"~/etc/domain.org/username/filter:"
	
	'if not first_delivery and error_message then finish endif

#E-Board
if
 $header_to: is "group@domain.org"
then
 deliver "user1@domain.org"
 deliver "user2@domain.org"
endif"'.

"~/etc/domain.org/username/filter.yaml (used by cPanel per https://forums.cpanel.net/threads/filter-vs-filter-yaml.292921/)"

'--- 
filter: 
  - 
    actions: 
      - 
        action: deliver
        dest: user1@domain.org
      - 
        action: deliver
        dest: user2@domain.org
    filtername: E-Board
    rules: 
      - 
        match: is
        opt: or
        part: "$header_to:"
        val: group@domain.org
    unescaped: 1
version: ''2.2'''.