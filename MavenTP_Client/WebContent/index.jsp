<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta http-equiv="Access-Control-Allow-Origin" content="*">
<title>Accueil</title>

</head>

<body>
	<h1>TP - Calculer une distance entre deux villes</h1>
	<h2>Veuillez sélectionner deux villes de votre choix :</h2>
	<br>
	<form method=post action="RecapServlet">
		<fieldset>

			<div class="autocomplete" style="width: 600px;">
				<label for="ville1" class="control-label">Ville numéro 1 : <span
					class="requis">*</span></label> <input id="ville1" type="text"
					name="ville1" placeholder="Ville numéro 1" required> 
					<input type="hidden" id="hiddenVille1" />
			</div>
			<br>
			<div class="autocomplete" style="width: 600px;">
				<label for="ville1" class="control-label">Ville numéro 2: <span
					class="requis">*</span></label> <input id="ville2" type="text"
					name="ville2" placeholder="Ville numéro 2" required>
			</div>
			<br>
			<div class="text-center">
				<input type="button" onClick="find();" value="Valider" />

			</div>
			<br>
		</fieldset>
	</form>


	Voici les informations des deux villes choisies :
	<br>
	<fieldset>
		Ville 1 : <span id="ville1id"></span>
		</p>
		Latitude : <span id="ville1latitude"></span>
		</p>

		Longitude : <span id="ville1longitude"></span>
		</p>
	</fieldset>

	<fieldset>
		Ville 2 : <span id="ville2id"></span>
		</p>
		Latitude : <span id="ville2latitude"></span>
		</p>
		Longitude : <span id="ville2longitude"></span>
		</p>
	</fieldset>
	<br><br>
	Vous pouvez calculer la distance entre ces deux villes en cliquant ici :   


	<input type="hidden" value="4" name="lat1" id="lat1" />
	<input type="hidden" value="5" name="lng1" id="lng1" />
	<input type="hidden" value="6" name="lat2" id="lat2" />
	<input type="hidden" value="7" name="lng2" id="lng2" />

	
	<input type="button" onClick="calculer();" value="Calculer" />
	<br>
	<br>
	<p>
		Résultat du calcul : <span id="resultatCalcul"></span> km.
	</p>

	<a href="Page2.html"> Go page 2</a>
	

	<script type="text/javascript">
	var tab=[];
 	
 	var request = new XMLHttpRequest()
 	request.open('GET', 'http://localhost:8181/get', true)
 	request.onload = function() {
 	  // Begin accessing JSON data here
 	  var data = JSON.parse(this.response);

 	  if (request.status >= 200 && request.status < 400) {
 	    data.forEach(ville => {
 	      console.log(ville.nom)
 	      tab.push(ville.nom)
 	      console.log(tab)
 	    })
 	  } else {
 	    console.log('error');
 	  }
 	}

 	request.send();

 	function autocomplete(inp, arr) {
 		  /*the autocomplete function takes two arguments,
 		  the text field element and an array of possible autocompleted values:*/
 		  var currentFocus;
 		  /*execute a function when someone writes in the text field:*/
 		  inp.addEventListener("input", function(e) {
 			  console.log("input");
 		      var a, b, i, val = this.value;
 		      /*close any already open lists of autocompleted values*/
 		      closeAllLists();
 		      if (!val) { return false;}
 		      currentFocus = -1;
 		      /*create a DIV element that will contain the items (values):*/
 		      a = document.createElement("DIV");
 		      a.setAttribute("id", this.id + "autocomplete-list");
 		      a.setAttribute("class", "autocomplete-items");
 		      /*append the DIV element as a child of the autocomplete container:*/
 		      this.parentNode.appendChild(a);
 		      /*for each item in the array...*/
 		      for (i = 0; i < arr.length; i++) {
 		        /*check if the item starts with the same letters as the text field value:*/
 		        if (arr[i].substr(0, val.length).toUpperCase() == val.toUpperCase()) {
 		          /*create a DIV element for each matching element:*/
 		          b = document.createElement("DIV");
 		          /*make the matching letters bold:*/
 		          b.innerHTML = "<strong>" + arr[i].substr(0, val.length) + "</strong>";
 		          b.innerHTML += arr[i].substr(val.length);
 		          /*insert a input field that will hold the current array item's value:*/
 		          b.innerHTML += "<input type='hidden' value='" + arr[i] + "'>";
 		          /*execute a function when someone clicks on the item value (DIV element):*/
 		              b.addEventListener("click", function(e) {
 		            	console.log("CHOISIR");
 		              /*insert the value for the autocomplete text field:*/
 		              inp.value = this.getElementsByTagName("input")[0].value;
 		              /*close the list of autocompleted values,
 		              (or any other open lists of autocompleted values:*/
 		           		
 		              closeAllLists();	 		  			
 		          });
 		          a.appendChild(b);
 		        }
 		      }
 		  });
 		  /*execute a function presses a key on the keyboard:*/
 		  inp.addEventListener("keydown", function(e) {
 		      var x = document.getElementById(this.id + "autocomplete-list");
 		      if (x) x = x.getElementsByTagName("div");
 		      if (e.keyCode == 40) {
 		        /*If the arrow DOWN key is pressed,
 		        increase the currentFocus variable:*/
 		        currentFocus++;
 		        /*and and make the current item more visible:*/
 		        addActive(x);
 		      } else if (e.keyCode == 38) { //up
 		        /*If the arrow UP key is pressed,
 		        decrease the currentFocus variable:*/
 		        currentFocus--;
 		        /*and and make the current item more visible:*/
 		        addActive(x);
 		      } else if (e.keyCode == 13) {
 		        /*If the ENTER key is pressed, prevent the form from being submitted,*/
 		        e.preventDefault();
 		        if (currentFocus > -1) {
 		          /*and simulate a click on the "active" item:*/
 		          if (x) x[currentFocus].click();
 		        }
 		      }
 		  });
 		  function addActive(x) {
 		    /*a function to classify an item as "active":*/
 		    if (!x) return false;
 		    /*start by removing the "active" class on all items:*/
 		    removeActive(x);
 		    if (currentFocus >= x.length) currentFocus = 0;
 		    if (currentFocus < 0) currentFocus = (x.length - 1);
 		    /*add class "autocomplete-active":*/
 		    x[currentFocus].classList.add("autocomplete-active");
 		  }
 		  function removeActive(x) {
 		    /*a function to remove the "active" class from all autocomplete items:*/
 		    for (var i = 0; i < x.length; i++) {
 		      x[i].classList.remove("autocomplete-active");
 		    }
 		  }
 		  function closeAllLists(elmnt) {
 		    /*close all autocomplete lists in the document,
 		    except the one passed as an argument:*/
 		    var x = document.getElementsByClassName("autocomplete-items");
 		    for (var i = 0; i < x.length; i++) {
 		      if (elmnt != x[i] && elmnt != inp) {
 		      x[i].parentNode.removeChild(x[i]);
 		    }
 		  }
 		}
 		/*execute a function when someone clicks in the document:*/
 		document.addEventListener("click", function (e) {
 		    closeAllLists(e.target);
 		});
 		}
 	
 		autocomplete(document.getElementById("ville1"), tab);
	 	autocomplete(document.getElementById("ville2"), tab);


	 	var request2 = new XMLHttpRequest()
		console.log("Dans script2");
		
		function findVille(ville, id, idlatitude, ilLongitude, idHiddenLat, idHiddenLng){		
			console.log("HTTP : "+ "http://localhost:8181/getFiltre?value="+ ville)
			request2.open('GET', 'http://localhost:8181/getFiltre?value='+ ville, true)
			request2.onload = function() {
			  // Begin accessing JSON data here
			  var data2 = JSON.parse(this.response);
			
			  if (request2.status >= 200 && request2.status < 400) {
				  data2.forEach(ville => {
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
			
			request2.send();
		}
		
		function find(){
			var ville1=document.getElementById("ville1").value
			var ville2=document.getElementById("ville2").value
			console.log("Ville 1: "+ ville1)
			console.log("Ville 2: "+ ville2)
			
			console.log("Dans Find")
			console.log("Ville 1 dans findVille : "+ ville1)
			findVille(ville1, 'ville1id', 'ville1latitude', 'ville1longitude', 'lat1', 'lng1');
			setTimeout(function(){
			    //do what you need here
				findVille(ville2, 'ville2id','ville2latitude', 'ville2longitude', 'lat2', 'lng2');
			}, 1000);
		}
		
		function calculer(){
			console.log("Dans calculer()")
			var lat1 = document.getElementById("lat1").value
			var lng1 = document.getElementById("lng1").value
			console.log("Lat 1 : "+ lat1 + " Lng1 : "+ lng1)
			var lat2 = document.getElementById("lat2").value
			var lng2 = document.getElementById("lng2").value
			console.log("Lat 2 : "+ lat2 + " Lng 2: "+ lng2)
			
			var resultat = Math.acos(Math.sin(lat1)*Math.sin(lat2) + Math.cos(lat1) * Math.cos(lat2)*Math.cos(lng2-lng1))*6371;
			console.log("Resultat : "+ resultat )
			document.getElementById("resultatCalcul").textContent = resultat;
		}
	</script>


</body>
</html>