/*	==================================================
	Question 1:
	We have an object storing salaries of our team
*/
	let salaries = {
		John: 100,
		Ann: 160,
		Pete: 130
	}
/*	Write the code to sum all salaries and store in the variable sum.
	Should be 390 in the example above.
	---------------------------------------------------*/
var sum = 0;
for (const [key, value] of Object.entries(salaries)) {
sum += value;
}

/*	==================================================
	Question 2:
	Create a function multiplyNumeric(obj) that multiplies all numeric 
	properties of obj by 2
	// before the call
*/
	let menu = {
		width: 200,
		height: 300,
		title: "My menu"
	};
/*	multiplyNumeric(menu);
	// after the call
	menu = {
		width: 400,
		height: 600,
		title: "My menu"
	};
	Please note that multiplyNumeric does not need to return anything. 
	It should modify the object in-place
	---------------------------------------------------*/
function multiplyNumeric(o){
    
    for (const [key, value] of Object.entries(o)) {
        if(!isNaN(value)){
            o[key] = value*2;    
        }       
    }
}

/*	==================================================
	Question 3:
	Write a function checkEmailId(str) that returns true if str contains '@' and ‘.’,
	otherwise false. Make sure '@' must come before '.' and there must be some 
	characters between '@' and '.'
	The function must be case-insensitive:
	---------------------------------------------------*/
let email_string = "r@gmail.com";

function checkEmailId(email_string){
 
    return /.*@[A-Za-z]+[\.].*/.test(email_string);
}

console.log(checkEmailId(email_string));

/*	==================================================
	Question 4:
	Create a function truncate(str, maxlength) that checks the length of the str and, 
	if it exceeds maxlength–replaces the end of str with the ellipsis character "...",
	to make its length equal to maxlength.
	The result of the function should be the truncated (if needed) string.
	
	truncate("What I'd like to tell on this topic is:", 20) = "What I'd like to te..."
	truncate("Hi everyone!", 20) = "Hi everyone!"
	---------------------------------------------------*/
function truncate(str, maxlength){

	let new_string = str;
	if(new_string.length>maxlength){
		new_string = new_string.slice(0, maxlength-1)+"...";
	}
	return new_string;
} 

/*	==================================================
	Question 5:
	Let’s try 5 array operations.
	
	
	---------------------------------------------------*/
//Create an array styles with items “James” and “Brennie”.
//James, Brennie
let arr = ["James", "Brennie"];

//Append “Robert” to the end.
//James, Brennie, Robert
arr.push("Robert");

//Replace the value in the middle by “Calvin”. 
//Your code for finding the middle value should work for any arrays with odd length.
//James, Calvin, Robert
let middle = Math.floor(arr.length/2);
arr[middle] = "Calvin";

//Remove the first value of the array and show it.
//Calvin, Robert
var name = arr.shift();
console.log(name);

//Prepend Rose and Regal to the array.
//Rose, Regal, Calvin, Robert
arr.unshift("Rose", "Regal");
/*==================================================*/