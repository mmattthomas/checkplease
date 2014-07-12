Checkplease Application
---------------------

###Want to get things done?  Make a checklist

This will allow you to:
* Create one-time, or recurring checklists
* Assign checklists to people via email
* Automatically send reminders of checklist information to users
* Track completion of these checklists

Development
* [X] Initial application built
* [X] Added Checklist model/scaffold
* [X] Added Devise authentication
* [X] Added Simple_Form gem
* [X] Added SLIM for simple haml markup
* [X] Added Checklist item child model/scaffold
* [X] Finish Parent/Child functionality for initial 2 objects
* [X] UI cleanup, add jquery datepicker
* [X] Added "Quiet Assets" gem, hides all asset info from WeBRICK output window
* [X] Add best_in_place for in place editing of line items
* [ ] Add checklist instance items
* [ ] UI cleanup
* 	[ ] Fix redirect/renders when items deleted
* [ ] Create notifications
* [ ] Create statistics.  How may times task is completed, how many times taskLIST is completed, etc.


Questions, things...
* [ ] Improve Datepicker UI.  Currently formats YYYY-MM-DD and doesn't fix when user formats differently
* [ ] Form partials, how should you do it?  form_for part IN or out of partial?  What if you want all buttons on same row?
* [ ] Simple Form problems with Devise UI
* [ ] How to get best_in_place feature functionality for adding a new line to list
* [ ] Question on SLIM... viewsource has whitespace removed - any way to get whitespace/indentation added back, especially for Dev environment?
