
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
	* [X] Fix redirect/renders when items deleted
* [X] Create notifications
* [X] Fix Delete button on modal forms... at the moment, I've reverted to javscript prompts :(
* [X] better confirm dialogs : http://www.pjmccormick.com/nicer-rails-confirm-dialogs-and-not-just-delete-methods
* [X] Better splash page before login (don't show the list)
* [X] Filter to just MY checklists after login
* [X] Add inline form for creating checklist items on the edit-checklist form
* [X] Redirect to EDIT of checklist after "New" checklist is created
* [X] Flash message (maybe permanent) after creating NEW checklist that gives instructions on what to do next
* [X] Hide checklist_id field on checklist items form (this form should be going away anyways)
* [X] replace "Open" link with "Delete" link for checklist items
* [X] Put login form right on the front page
* [ ] Create statistics.  How may times task is completed, how many times taskLIST is completed, etc. Investigate "dashing" gem
* [ ] Notificaiton to create user with completion statistics
* [ ] Add a "Name" field to User Model & Registration/Settings forms
* [ ] Gut/Improve simple forms used for registration
	* [X] login
	* [X] register
	* [ ] forgot password
	* [X] profile
	* [ ] make sure error messages work on all of these
* [X] Add cancancan gem
* [ ] Tighten authorization, remove needless routes
* [ ] Remove assigned_to dropdown, instead, email address (or dropdown with name)
* [ ] Added features to Checklist:
*		[ ] Recurring is OPTIONAL
*   [ ] Start date or "First day"
*   [ ] Hour, or Time of day when reminder should be sent
* [ ] A way for users who aren't yet signed up to sign up when they get an email w/ task link (also validation here)
* [ ] Tasklist instance, some callback positive re-inforcement when items are checked.  And actions to take when checkboxes are checked some positive way
* [ ] Anonymous feature : option on checklist, or deduce based on if email is in user table, generate and send obfuscated task id URLs.  More security, etc.
