/**
 * 
 */

var request = new XMLHttpRequest()
		console.log("Dans script2");
		var ville1=document.getElementById("ville1").value
		var ville2=document.getElementById("ville2").value
		console.log("Ville :0"+ ville1)
		console.log("Ville :0"+ ville2)
		
		function findVille(ville, id, idlatitude, ilLongitude, idHiddenLat, idHiddenLng){		
			console.log("HTTP : "+ "http://localhost:8181/getFiltre?value="+ ville)
			request.open('GET', 'http://localhost:8181/getFiltre?value='+ ville, true)
			request.onload = function() {
			  // Begin accessing JSON data here
			  var data = JSON.parse(this.response)
			
			  if (request.status >= 200 && request.status < 400) {
			    data.forEach(ville => {
			      console.log(ville.nom)
			      console.log(ville.latitude)
			      console.log(ville.longitude)
			      var variable = ville.nom
			      console.log("ID : "+ id)
			      console.log("value ville : "+ variable)
			      document.getElementById(id).textContent = variable
			      document.getElementById(idlatitude).textContent = ville.latitude
			      document.getElementById(ilLongitude).textContent = ville.longitude
			      
			      var tag = document.getElementById(idHiddenLat).value;
			      console.log("tag : "+ tag);
			      tag=ville.latitude;
			      console.log("tag2 : "+ tag);
			      
			      var tag = document.getElementById(idHiddenLng).value;
			      console.log("tag : "+ tag);
			      tag=ville.longitude;
			      console.log("tag2 : "+ tag);
			      
			      document.getElementById(idHiddenLat).value = ville.latitude;
			      alert(document.getElementById(idHiddenLat).value);
			      
			      document.getElementById(idHiddenLng).value = ville.longitude;
			      alert(document.getElementById(idHiddenLng).value);
			      
			    })
			  } else {
			    console.log('error');
			  }
			}
			
			request.send();
		}
		

		function find(){
			findVille(ville1, 'ville1id', 'ville1latitude', 'ville1longitude', 'lat1', 'lng1');
			setTimeout(function(){
			    //do what you need here
				findVille(ville2, 'ville2id','ville2latitude', 'ville2longitude', 'lat2', 'lng2');
			}, 1000);
		}
		