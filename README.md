# MediaStack iOS Demo 

Integrated livenews api from public apis https://mediastack.com/documentation


## Architecture
Used Protocol oriented programming MVVM Architecture.

Decided to go with MVVM architecture for better programming practices, maintain code in modular way with sophisticated module based structure. Also it is easier to keep business layer in ViewModel seperate from view & it helpful for mentioning code longer time as maintaince purpose.

<br>
<img height="700" src="https://github.com/mukeshlokare/ImagesFiles/blob/master/download.png"/>
<br>

**Aspects in MediaStack Project Setup:**

**Model**: Reponsible to manage the data.

**View**: It represent UIView or UIViewController objects. It may be xib or storyboard which is reposible for display the prepared data by ViewModel.

**ViewModel**: ViewModel contains & hinde all business logic that need to evaluate the data for visual presentation. Code listening for model changes.
Module level Webservice & API class: Contains similar kind of api calls that may come under specific module. Ex. In our app news is one module in media stack app so in news module all api will come under that class. In future if any new module gets added into mediastack app as per architecture new module webservice & api file has to create.

**NetworkManager:** NetworkManager is reponsible to execute the api call with the help of provider prepared by webservice class with help of API. On successful execution of API request genric parsing will takes place & with the help of completion handler(i,e escaping closure) reponse sends back for further evaluation and on failure handled error response reusable way from one place.

**Coordinator Pattern:** Added coordinator patter to handle the routing mechanism between screens..,

**Environment Support:** Application level data & constants handling based on enviroment.., i.e Development, UAT & Production.

**SOLID Principles:** Used solid principles to achieve better programming practice.


### MediaStack Features.
Users can see list of news & see the detail news in the application.

Application will work in online mode. Handle no network/data conditions.

### Some glimpse of Media stack app:

 
 - Application Icon & Spalsh: 
 <br>
 <img height="700" src="https://github.com/mukeshlokare/ImagesFiles/blob/master/Screenshot%202022-03-03%20at%204.32.19%20PM.png"/>
 <br>

 - NewsList:
 <br>
 <img height="700" src="https://github.com/mukeshlokare/ImagesFiles/blob/master/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-03-03%20at%2016.06.17.png"/>
 <br>
 - News Detail (In webview): 
 <br>
 <img height="700" src="https://github.com/mukeshlokare/ImagesFiles/blob/master/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-03-03%20at%2016.06.26.png"/>
 <br>
 
 - No Internet: 
 <br>
 <img height="700" src="https://github.com/mukeshlokare/ImagesFiles/blob/master/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-03-03%20at%2016.07.28.png"/>
 <br>
 
 - No any news: 
<br>
 <img height="700" src="https://github.com/mukeshlokare/ImagesFiles/blob/master/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-03-03%20at%2016.07.06.png "/>
 <br>
 
 - Filter scene
<br>
 <img height="700" src="https://github.com/mukeshlokare/ImagesFiles/blob/master/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-03-04%20at%2012.00.32.png"/>
 <br>
 
 - Server error scene
<br>
 <img height="700" src="https://github.com/mukeshlokare/ImagesFiles/blob/master/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-03-04%20at%2012.01.27.png"/>
 <br>
 
