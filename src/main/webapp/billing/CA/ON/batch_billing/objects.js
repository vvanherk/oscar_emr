function provider(name, group, b_ctr){
	this.name = name;
	this.group = group;
	this.b_ctr = b_ctr;
}

function demographic(jsonObj){
	this.id = jsonObj.id;
	this.name = jsonObj.name;
	this.dob = jsonObj.dob;
	this.health_card = jsonObj.health_card;
	this.gender = jsonObj.gender;
}

function invoice(){
	this.demo = "";

	this.date = "";	//use for admission date as well
//	this.start = "";
//	this.end = "";
	this.time = "";

	this.status = "Ready";
	this.rdoctor = "";
	this.sli_code = "";

	this.items= new Array();

//	this.description="";
	this.manual="";
	this.notes="";

	this.inv_amount=0.00;

	this.update_inv_total = function(){
		this.inv_amount=0.00;
		for(it in this.items){
			this.inv_amount = parseFloat(this.inv_amount) + parseFloat(this.items[it].total);
			this.inv_amount = parseFloat(this.inv_amount).toFixed(2);
		}
	}
	

}


function item(){
//	this.from = "";
//	this.days = "";
	this.code = "";
	this.amount=0;
	this.units= 0;
	this.percent = 0.0;
	this.total=0;
	this.dx_code = "";

}



