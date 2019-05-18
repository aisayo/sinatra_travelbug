
Travelbug: Create, store, edit, and delete your upcoming trips!
Usage
Clone this repository and bundle to install the required gems. Run rake db:migrate and then rake db:seed to add a few projects and users to the database. Run shotgun to preview in your browser.

Description
This is a web app that uses an MVC framework including multiple models, validations for logins & signups, and CRUD functionality.

In this app, a user can create a trip and store upcoming trips. This trip will include parameters of a name, location, and date. This newly created trip will then be persisted to the database. A user can create a new trip, edit or delete an existing trip. The user may only edit/delete a project if it belongs to them. 
