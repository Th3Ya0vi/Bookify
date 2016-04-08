# Bookify
An iOS app which connects university students to ease getting textbooks.

**Bookify** is a book sharing app used to simplify trading/leasing textbooks within Texas A&M University students.

Time spent(Gerardo): **16** hours spent in total

## User Stories
The following **required** functionalities are completed:
- [x] Be able to sign in and register
- [x] Implement home screen, which consists of a table view as well as a collection view to display multiple categories of books
- [x] Implement Popular, Sell, and Profile Control Bar Tabs
- [x] Be able to post a book using the ISBN number and send it to the database as well as display in the app
- [x] Search functionality from our own database and RESTful API
- [x] Users will be able to communicate using the app (via a chat mechanism)

The following **optional** features are to be implemented:
- [ ] Be able to use the camera to detect a barcode which gets the information necessary to post a book
- [ ] Be able to have a wishlist
- [ ] Be able to invite friends to use the app
- [ ] Be able to pay in advance  

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
- [ ] profile picture - file (optional)
- [ ] description - text
- [ ] classes - text (optional)
- [ ] wish list - text (optional)
- [ ] posts - text
- [ ] message - text
- [ ] created at - time
- [ ] email - email

####Books
- [ ] title - text
- [ ] author - text
- [ ] bookcover - file
- [ ] isbn - number

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='https://raw.githubusercontent.com/Bookify/Bookify/master/Files/Animations/Animation.gif' title='Video Walkthrough Sprint 1' width='' alt='Video Walkthrough' />


<img src='https://raw.githubusercontent.com/Bookify/Bookify/master/Files/Animations/Animationv2.gif' title='Video Walkthrough Sprint 2' width='' alt='Video Walkthrough' />


<img src='https://raw.githubusercontent.com/Bookify/Bookify/master/Files/Animations/Animationv3.gif' title='Video Walkthrough Sprint 3' width='' alt='Video Walkthrough' />
GIF created with [LiceCap](http://www.cockos.com/licecap/).
