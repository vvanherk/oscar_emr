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

	this.saveInvoiceInfo = function(rdoc, sli, man, note){	//for quick update
		this.rdoctor = rdoc;
		this.sli_code = sli;
		this.manual = man;
		this.notes = note;
	}
	
	this.addItem = function(newItem){		//quick add
		this.items.push(newItem);

		this.inv_amount = parseFloat(this.inv_amount) + parseFloat(newItem.total);
		this.inv_amount = parseFloat(this.inv_amount).toFixed(2);
	}

	this.removeItem = function(oldItem){	//quick remove
		this.items.pop(oldItem);
		this.inv_amount = parseFloat(this.inv_amount) - parseFloat(oldItem.total);
		this.inv_amount = parseFloat(this.inv_amount).toFixed(2);
	}

	this.saveItems = function(unSavedItems){	//batch add/remove of items
		if(unSavedItems.length > 0){
			if(this.inv_amount == "NaN") { 
				this.inv_amount = 0.0;
				this.items  = []; 
			}
			for(var i = 0; i < unSavedItems.length; i++){
				if(i + 1 > this.items.length){ this.addItem(unSavedItems[i]); }	//if all things match until the end, just add
				else if(unSavedItems[i] != this.items[i]){	//if there is discrepancy, replace
					this.inv_amount = parseFloat(this.inv_amount) - parseFloat(this.items[i].total);
					this.inv_amount = parseFloat(this.inv_amount) + parseFloat(unSavedItems[i].total);
					this.inv_amount = parseFloat(this.inv_amount).toFixed(2);
					this.items[i] = unSavedItems[i];
				}
			}
			if(unSavedItems.length < this.items.length){	//if items were removed
				for(var i = unSavedItems.length; i < this.items.length; i++){
					this.removeItem(this.items[i]);
				}
			}
		}
	}

}


function item(){
	this.from = "";
	this.days = "";
	this.code = "";
	this.amount=0;
	this.units= 0;
	this.percent = 0.0;
	this.total=0;
	this.dx_code = "";

	this.updateUnits = function(newUnt){
		this.units = newUnt;
		this.total = this.amount*this.units*this.percent;
		this.total = parseFloat(this.total).toFixed(2);
	}

}



