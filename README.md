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
* [X] Add checklist instance items
* [X] UI cleanup
* 	[X] Fix redirect/renders when items deleted
* [X] Create notifications
* [ ] Create statistics.  How may times task is completed, how many times taskLIST is completed, etc.
* [X] better confirm dialogs : http://www.pjmccormick.com/nicer-rails-confirm-dialogs-and-not-just-delete-methods
* [X] Better splash page before login (don't show the list)
* [X] Filter to just MY checklists after login
* [ ] Add inline form for creating checklist items on the edit-checklist form
* [ ] Add a "Name" for each user
* [ ] A way for users who aren't yet signed up to sign up when they get an email w/ task link (also validation here)
* [ ] Tasklist instance, actions to take when checkboxes are checked some positive signal

Questions, things...
* [ ] Improve Datepicker UI.  Currently formats YYYY-MM-DD and doesn't fix when user formats differently
 (OR MAYBE REMOVE JQUERY DATEPICKER AND GO WITH ALTERNATIVE)
* [X] Form partials, how should you do it?  form_for part IN or out of partial?  What if you want all buttons on same row?
* [ ] Simple Form problems with Devise UI
* [X] How to get best_in_place feature functionality for adding a new line to list
* [X] Related ^ look into using partials with collections (see railscasts 74)
* [ ] Question on SLIM... viewsource has whitespace removed - any way to get whitespace/indentation added back, especially for Dev environment?
