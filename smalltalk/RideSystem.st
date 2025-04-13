"====================================================================="
" Ride Sharing System Implementation "
"====================================================================="

"Remove existing package if needed"
Smalltalk at: #RideSharingSystem ifPresent: [:p | p removeFromSystem].

"Create the package"
Package named: 'RideSharingSystem'.

"====================================================================="
" Ride Class (Base Class) "
"====================================================================="
Object subclass: #Ride
    instanceVariableNames: 'rideID pickupLocation dropoffLocation distance fare'
    classVariableNames: ''
    package: 'RideSharingSystem'.

Ride >> initializeWithID: anID pickup: pickup dropoff: dropoff dist: dist
    rideID := anID.
    pickupLocation := pickup.
    dropoffLocation := dropoff.
    distance := dist.
    fare := 0.

Ride >> calculateFare
    "Default fare calculation - $1 per mile"
    fare := distance * 1.
    ^fare.

Ride >> rideDetails
    ^String streamContents: [ :s |
        s nextPutAll: 'Ride ID: ', rideID;
            nextPutAll: ', From: ', pickupLocation;
            nextPutAll: ', To: ', dropoffLocation;
            nextPutAll: ', Distance: ', distance asString, ' miles';
            nextPutAll: ', Fare: $', fare asString ].

Ride >> fare
    ^fare.

"====================================================================="
" StandardRide Subclass "
"====================================================================="
Ride subclass: #StandardRide
    instanceVariableNames: ''
    classVariableNames: ''
    package: 'RideSharingSystem'.

StandardRide >> calculateFare
    "Standard fare - $1.5 per mile"
    fare := distance * 1.5.
    ^fare.

"====================================================================="
" PremiumRide Subclass "
"====================================================================="
Ride subclass: #PremiumRide
    instanceVariableNames: ''
    classVariableNames: ''
    package: 'RideSharingSystem'.

PremiumRide >> calculateFare
    "Premium fare - $2.5 per mile with $5 base fee"
    fare := 5 + (distance * 2.5).
    ^fare.

"====================================================================="
" Driver Class "
"====================================================================="
Object subclass: #Driver
    instanceVariableNames: 'driverID name rating assignedRides'
    classVariableNames: ''
    package: 'RideSharingSystem'.

Driver >> initializeWithID: anID name: aName rating: aRating
    driverID := anID.
    name := aName.
    rating := aRating.
    assignedRides := OrderedCollection new.

Driver >> addRide: aRide
    assignedRides add: aRide.
    aRide calculateFare.

Driver >> getDriverInfo
    ^String streamContents: [ :s |
        s nextPutAll: 'Driver ID: ', driverID;
            nextPutAll: ', Name: ', name;
            nextPutAll: ', Rating: ', rating asString;
            nextPutAll: ', Completed Rides: ', assignedRides size asString ].

Driver >> viewRides
    assignedRides do: [ :ride | 
        Transcript show: ride rideDetails; cr ].

"====================================================================="
" Rider Class "
"====================================================================="
Object subclass: #Rider
    instanceVariableNames: 'riderID name requestedRides'
    classVariableNames: ''
    package: 'RideSharingSystem'.

Rider >> initializeWithID: anID name: aName
    riderID := anID.
    name := aName.
    requestedRides := OrderedCollection new.

Rider >> requestRide: aRide
    requestedRides add: aRide.
    aRide calculateFare.

Rider >> viewRides
    requestedRides do: [ :ride | 
        Transcript show: ride rideDetails; cr ].

"====================================================================="
" Demonstration Code "
"====================================================================="
RideSharingSystem >> demonstrate
    | standard premium driver rider rides |
    
    Transcript clear.
    
    "Create some rides"
    standard := StandardRide new initializeWithID: 'S123' pickup: 'Main St' dropoff: 'Central Park' dist: 5.
    premium := PremiumRide new initializeWithID: 'P456' pickup: 'Airport' dropoff: 'Downtown' dist: 15.

    "Create a driver"
    driver := Driver new initializeWithID: 'D789' name: 'John Doe' rating: 4.8.
    driver addRide: standard.
    driver addRide: premium.

    "Create a rider"
    rider := Rider new initializeWithID: 'R321' name: 'Alice Smith'.
    rider requestRide: standard.
    rider requestRide: premium.

    "Demonstrate polymorphism"
    rides := OrderedCollection with: standard with: premium.
    Transcript cr; show: '=== Polymorphism Demonstration ==='; cr.
    rides do: [ :r | 
        Transcript show: 'Calculating fare for ride ', r rideID; cr.
        Transcript show: 'Fare: $', r calculateFare asString; cr.
        Transcript show: r rideDetails; cr; cr ].

    "View driver and rider info"
    Transcript cr; show: '=== Driver Information ==='; cr.
    Transcript show: driver getDriverInfo; cr.
    Transcript cr; show: 'Driver ride history:'; cr.
    driver viewRides.

    Transcript cr; show: '=== Rider Information ==='; cr.
    Transcript show: 'Rider: ', rider riderID, ' - ', rider name; cr.
    Transcript cr; show: 'Rider ride history:'; cr.
    rider viewRides.