# Bookify
An iOS app which connects university students (TAMU) where they can easily sell and rent various textbooks

**Bookify** is a book sharing app used to simplify buying textbooks within Texas A&M for TAMU students.

Time spent: **6** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] Be able to sign in and register
- [ ] Implement home screen, which consists of a table view as well as a collection view to display multiple categories of books
- [x] Implement Popular, Sell, and Profile Control Bar Tabs
- [x] Be able to post a book using the ISBN number and send it to the database as well as display in the app
- [ ] Search functionality from our own database and RESTful API
- [ ] Users will be able to communicate using the app (via a chat mechanism)

The following **optional** features are implemented:

- [ ] Be able to use the camera to detect a barcode which gets the information necessary to post a book
- [ ] Be able to have a wishlist
- [ ] Be able to invite friends to use the app
- [ ] Be able to pay in advance through Venmo API (Possible optional) 

##Wireframes
You can view the wireframes here:
<img src='http://i.imgur.com/zKcNJmB.jpg?1' title='Wireframes' width='450' height='450'/>

##Schema
The database schema consists of a no-SQL databse implementing Parse in the Heroku cloud system. The application consists of a "User" and "Books." 

####User
- [ ] username - text
- [ ] first name - text
- [ ] last name - text
- [ ] username password - text
- [ ] profile - text
- [ ] profile picture - file
- [ ] description - text
- [ ] classes - text
- [ ] wish list - text
- [ ] posts - text
- [ ] message - text
- [ ] created at - time
- [ ] email - email

####Books
- [ ] title - text
- [ ] author - text
- [ ] bookcover - file
- [ ] isbn - number
- [ ] category - text
- [ ] related - text

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/link/to/your/gif/file.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).
