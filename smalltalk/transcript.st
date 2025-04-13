"First declare all temporary variables"
| standard premium driver rider rides |

"Clear the Transcript first"
Transcript clear.

"Create ride instances"
standard := StandardRide new initializeWithID: 'S123' pickup: 'Main St' dropoff: 'Central Park' dist: 5.
premium := PremiumRide new initializeWithID: 'P456' pickup: 'Airport' dropoff: 'Downtown' dist: 15.

"Create and setup driver"
driver := Driver new initializeWithID: 'D789' name: 'John Doe' rating: 4.8.
driver addRide: standard.
driver addRide: premium.

"Create and setup rider"
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

"View driver information"
Transcript cr; show: '=== Driver Information ==='; cr.
Transcript show: driver getDriverInfo; cr.
Transcript cr; show: 'Driver ride history:'; cr.
driver viewRides.

"View rider information"
Transcript cr; show: '=== Rider Information ==='; cr.
Transcript show: 'Rider: ', rider riderID, ' - ', rider name; cr.
Transcript cr; show: 'Rider ride history:'; cr.
rider viewRides.