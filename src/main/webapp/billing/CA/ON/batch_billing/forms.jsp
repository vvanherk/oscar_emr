<%
	String providerSelectionList = request.getParameter("providers");
	String clinicSelectionList = request.getParameter("locations");
	String superCodeSelectionList = request.getParameter("superCodes");
	String pSpecSelectionList = request.getParameter("rDoctors");
	String sliCodeSelectionList = request.getParameter("sliCodes");
%>
<html><head>
	<link rel="stylesheet" type="text/css" href="main.css">
</head><body>

<div id="clinical">
	<section id="batch-details">
		<div class="row-fluid">
			<div class="span10 billing-form-layout batch-info">
				<div class="span12"> 			<!-- for pages with 2 rows -->
					<div><label for="b_provider"> Billing Provider </label><select id="b_provider" name="bprov" class="input-small combobox"><%= providerSelectionList %></select></div>
					<div><label for="group_no"> Group # </label><input type="text" class="input-mini uneditable-input" placeholder="00000" id="group_no" name="group_no" readonly="true"></div>
					<div><label for="provider"> Provider </label><select id="provider" name="prov" class="input-small combobox"><%= providerSelectionList %></select></div>
					<div><label for="location"> Location </label><select id="location" name="loc" class="input-medium combobox"><%= clinicSelectionList %></select></div>
					<div><label for="billing-center"> Billing Center </label><input type="text" class="input-small uneditable-input" placeholder="Hamilton" id="billing-center" name="bcenter" readonly="true"></div>
				</div>
				<div class="span12 formrow" style="margin-left:-5px"> 			<!-- for pages with 2 rows -->
					<div class="span11">
						<div id="fdate" class="search-input datepicker">
							<label for="from-date"> From Date </label>
							<div id="from-date" class="input-append">
								<input id="from-dt" name="from" data-format="yyyy-MM-dd" type="text" class="input-small" placeholder="YYYY-MM-DD"></input>
								<span class="add-on"><i data-time-icon="icon-time" data-date-icon="icon-calendar"></i></span>
							</div>
						</div>						
						<div id="tdate" class="search-input datepicker">
							<label for="to-date"> To Date </label>
							<div id="to-date" class="input-append">
								<input id="to-dt" name="to" data-format="yyyy-MM-dd" type="text" class="input-small"placeholder="YYYY-MM-DD"></input>
								<span class="add-on"><i data-time-icon="icon-time" data-date-icon="icon-calendar"></i></span>
							</div>
						</div>
						<div><button id="create-list" type="submit" class="btn"> Create List </button></div>
						<div class="span1"></div>
						<div><label for="supercode"> Super Code </label><select id="supercode" class="input-medium combobox"><%= superCodeSelectionList %></select></div>
						<div><button id="scApply" type="submit" class="btn"> Apply </button></div>
					</div>
				</div>
			</div>
			<div class="span2 billing-form-layout batch-total">
				<form id="batch-total-form">
					<button id="save-batch" class="btn"> Save Billing </button>
					<label for="batch-total-amt"> Batch Total </label>
					<input id="batch-total-amt" type="text" class="input-small uneditable-input" placeholder="$0.00">
				</form>
			</div>
		</div>
	</section>
	<section id="batch-invoices">
		<table class="table table-striped table-hover table-condensed table-header" id="invList_header">
			<thead>
				<tr>
					<th class="bc_apply" style="width: 2%"><input id="select-all" type="checkbox"></th>
					<th class="date" style="width: 7%">Date</th>
					<th class="time" style="width: 6%">Time</th>
					<th class="patient-name" style="width: 15%">Patient Name</th>
					<th class="health-card-number" style="width: 9%">HCN</th>
					<th class="date-of-birth" style="width: 7%">DOB</th>
					<th class="man_note">Manual Note</th>
					<th class="notes" style="width: 20%">Notes</th>
					<th class="service-description" style="width: 10%">Service Desc</th>
					<th class="amount" style="width: 6%">Amount</th>
				</tr>
			</thead>
		</table>
		<div class="bodycontainer scrollable">
			<table id="invList_body" class="table table-hover table-striped table-condensed table-scrollable">
				<tbody>
					<td style="text-align: center"> No items: Please choose query attributes above</td>
				</tbody>
			</table>
		</div>
	</section>
	<section id="invoice-detail" class="invisible">
		<div class="row-fluid">
			<div id="invoice-status" class="span7" style="float: left">
				<div><label for="invStatus">Invoice Status </label>
					<select id="invStatus" class="input-mini combobox">
					<option value="ready">Ready</option>
					<option value="hold">Hold</option>
					</select>
				</div>
				<div><label for="rdoctor">Referral Doctor</label>
					<select id="rdoctor" class="input-small combobox"><%= pSpecSelectionList%></select>
				</div>
				<div><label for="sli_code"> SLI Code </label>
					<select id="sli_code" class="input-small combobox"><%= sliCodeSelectionList %></select>
				</div>
				<div><label for="billing-type"> Billing Type </label>
					<select id="billing-type" name="btype" class="input-mini combobox"><option value="OHIP">OHIP</option><option value="RMB">RMB</option></select>
				</div>
			</div>
			<div id="manual-and-notes" class="span5">
				<div class="form-inline no-label" style="width: 75px;">
					<label for="manualCHK" class="inline"> Manual </label> 
					<input class='inline' type="checkbox" id="manualCHK" style="position:relative; top:-3px">
				</div>
				<div class="span11 no-label" style="margin-left:0px"> <input type="text" class="input-100" id="manual_text" readonly="true"></div>
				<div class="no-label" style="width: 75px;">
					<label for="b_notes">Bill Notes:</label>
				</div>
				<div class="span11 no-label" style="margin-left:0px">
					<input class="input-100" type="text" id="b_notes">
				</div>
			</div>
			<div id="invoice-items" class="span8" style="margin-left: 5px;">
				<div id="items-header" class="row-fluid" style="margin-left:55px; font-size:1.1em">
					<div class="span1"> Code </div>
					<div class="span4"> Description </div>
					<div class="span1"> Dx </div>
					<div class="span1"> Amount </div>
					<div class="span1"> Units </div>
					<div class="span1"> Percent</div>
					<div class="span1"> Total </div>
				</div>
				<div id="items-master" class="tablerow row-fluid invisible span12" style="margin-left:10px; position: absolute; width:800px;">
					<div class="span1" style="width: 30px"> <button class="btn" id="delete_item"><span class="icon-trash"></span></button> </div>
					<div class="span1"> <input type="text" class="input-100" id="b_code"> </div>
					<div class="span4"> <input type="text" class="input-100" id="description"> </div>
					<div class="span1"> <input type='text' class="input-100" id="dx"> </div>
					<div class="span1"> <input type="text" class="input-100" id="amount" readonly="true"> </div>
					<div class="span1"> <input type="text" class="input-100" id="units"></div>
					<div class="span1"> <input type="text" class="input-100" id="percent" readonly="true">	</div>
					<div class="span1"> <input type='text' class="input-100" id="l_total"> </div>
					<div class="span1"> <button class="btn" id="add_item"><span class="icon-plus"></span></button> </div>
				</div>
				<div class="row-fluid"><span id="items-space"> </span></div>
				<div id="items-footer" class="span12">
					<div class="span1 offset10" id="total"> $0.00 </div>
				</div>
				<div id="patient-control" class="span12">
					<div class="span1"><button class="btn" id="prev_patient"><span class="icon-chevron-left"></span></button></div>
					<div class="span10"></div>
					<div class="span1"><button class="btn" id="next_patient"><span class="icon-chevron-right"></span></button></div>
				</div>
			</div>
		</div>
	</section>
</div>














<div id="offsite">
	<section id="batch-details" style="min-width:800px;">
	  <div class="row-fluid">
	      <div class="span10 billing-form-layout batch-info">
		<div class="span12"> 			<!-- for pages with 2 rows -->
			<div><label for="b_provider"> Billing Provider </label><select id="b_provider" class="input-small combobox"><%= providerSelectionList %></select></div>
			<div><label for="group_no"> Group # </label><input type="text" class="input-mini uneditable-input" placeholder="00000" id="group_no"></div>
			<div><label for="billing-type"> Billing Type </label><select id="billing-type" class="input-mini combobox"><option value="d1">OHIP</option></select></div>
			<div><label for="location"> Location </label><select id="location" name="loc" class="input-small combobox"><%= clinicSelectionList %></select></div>
			<div><label for="billing-center"> Billing Center </label><input type="text" class="input-medium uneditable-input" placeholder="Hamilton" id="billing-center"></div>
			<div><button id="hold" type="submit" class="btn"> Show Hold </button></div>
		</div>
		<div class="span12 formrow" style="margin-left:500px"> 			<!-- for pages with 2 rows -->
			<div><label for="supercode"> Super Code </label><select id="supercode" class="input-medium combobox"><%= superCodeSelectionList %></select></div>
			<div><button id="scApply" type="submit" class="btn"> Apply </button></div>
		</div>
	      </div>
	      <div class="span2 billing-form-layout batch-total">
			<form id="batch-total-form">
				<button id="save-batch" class="btn"> Save Billing </button>
				<label for="batch-total-amt"> Batch Total </label>
				<input id="batch-total-amt" type="text" class="input-small uneditable-input" placeholder="$0.00">
			<form>
	      </div>
	  </div>
	</section>
	<section id="batch-invoices">
		<div class="row-fluid">
		  <div class="span12">
		  	<table class="table table-hover table-condense" id="invList">
		  		<thead class="header">
		  			<tr><th>Service Date</th><th>Patient Name</th>
		  			<th>HCN</th><th>DOB</th><th>Remarks</th><th>Amount</th></tr>
		  		</thead>
		  		<tbody>

		  		</tbody>
		  		<tfoot>
		  		</tfoot>
		  	</table>
		  </div>
		</div>
	</section>
	<section id="invoice-detail">
	    <div class="row-fluid">
		    <div id="invoice-demographic" class="span12">
			<input id="demo-name-search" type="text" class="input-medium autocomplete" placeholder="Smith, John" style="margin-left:20%">
			<input id="demo-hin-search" type="text" class="input-small autocomplete" placeholder="1234567890" style="margin-left:7%">
			<input id="demo-dob-search" type="text" class="input-small autocomplete" placeholder="yyyy-mm-dd" style="margin-left:5%">
		   </div>
		   <div id="invoice-status" class="span7" style="width:700px; float: left">
			<div class="span12" style="margin-left:10px">
			     <div><label for="invStatus">Invoice Status </label>
		      		   <select id="invStatus" class="input-mini combobox">
					<option value="ready">Ready</option>
		      			<option value="hold">Hold</option>
		      		   </select>
		      	     </div>
			     <div style="margin-left:5%"><label for="rdoctor">Referral Doctor</label>
		      		   <select id="rdoctor" class="input-small combobox"><%= pSpecSelectionList%></select>
		      	     </div>
		      	     <div style="margin-left:5%"><label for="sli_code"> SLI Code </label>
		      		    <select id="sli_code" class="input-small combobox"><%= sliCodeSelectionList %></select>
		       	     </div>
			</div>
			 <div class="datepicker" style="width: 150px">
					<label for="admission_date"> Service Date:</label>
						<div id="admission_date" class="input-append">
							<input data-format="yyyy-MM-dd" type="text" placeholder="YYYY-MM-DD" style="width:60%">
							<span class="add-on">
							  <i data-time-icon="icon-time" data-date-icon="icon-calendar">
							  </i>
							</span>
						</div>
			</div>
			<div id="dx-space" style="width:500px">
				<div id="dx-header" class="tablerow row-fluid" style=" margin-left:25px">
				     <div class="span2 offset1"> <label for="dx_code"> Dx Code</label> </div>
				     <div class="span3"> Dx Description</div>
				</div>
			</div>
			<div id="dx_master" class="tablerow span12 diagnostic invisible" style="position:absolute; width:100px">
			     <div class="span1">
	      			<button class="btn invisible" id="delete_Dx" style="position:relative;"><span class='icon-trash'></span></button>
	      		     </div>
			      	<div class="span2"><input type="text" class="autocomplete input-100 dxCode" id="dx_code" data-provide="typeahead" ></div>
			      	<div class="span3"><input type="text" class="autocomplete input-100 dxDesc" id="dx_description" data-provide="typeahead"></div>
			      	<div class="span3"><button class="btn" id="add_Dx">Add Dx</button></div>
			</div>
		  		<div id="invoice-items" class="span12">
				<div id="items-header" class="row-fluid" style="margin-left:55px; font-size:1.1em">
				     <div class="span1"> Code </div>
				     <div class="span4"> Description </div>
				     <div class="span1"> Amount </div>
				     <div class="span1"> Units </div>
				     <div class="span1"> Percent</div>
				     <div class="span1"> Total </div>
				</div>
				<div id="items-master" class="tablerow row-fluid invisible" style="margin-left:10px; position: absolute; width:800px;">
				     <div class="span1" style="width: 30px"> <button class="btn" id="delete_item"><span class="icon-trash"></span></button> </div>
				     <div class="span1"> <input type="text" class="input-100" id="b_code"> </div>
				     <div class="span4"> <input type="text" class="input-100" id="description"> </div>
				     <div class="span1"> <input type="text" class="input-100" id="amount" readonly="true"> </div>
				     <div class="span1"> 
					<input type="text" class="input-100" id="units"></div>
				     <div class="span1"> 
					<input type="text" class="input-100" id="percent" readonly="true">	</div>
				     <div class="span1"> 
					<input type='text' class="input-100" id="l_total"> </div>
				     <div class="span1"> <button class="btn" id="add_item"><span class="icon-plus"></span></button> </div>
				</div>
				<span id="items-space"> </span>
				<div id="items-footer" class="span12">
					<div class="span1 offset10" id="total"> $0.00 </div>
				</div>
				<div id="patient-control" class="span12">
					<div style="width: 30px; margin-left: 5px"><button class="btn" id="prev_patient"><span class="icon-chevron-left"></span></button></div>
					<div class="span10"></div>
					<div><button class="btn" id="next_patient"><span class="icon-chevron-right"></span></button></div>
				</div>
		  	</div>
		   </div>
		   <div id="manual-and-notes" style="margin-left:720px">
			<div class="form-inline no-label" style="width: 75px; position:relative; top:25px">
				<label for="manualCHK" class="inline"> Manual </label> 
				<input class='inline' type="checkbox" id="manualCHK" style="position:relative; top:-3px">
			</div>
		      	<div class="span11 no-label" style="margin-left:0px"> <input type="text" class="input-100" id="manual_text" readonly="true"></div>
		      	<div class="no-label" style="width: 75px; position:relative; top:25px">
		      		<label for="b_notes">Bill Notes:</label>
		      	</div>
		      	<div class="span11 no-label" style="margin-left:0px">
		      		<input class="input-100" type="text" id="b_notes">
		      	</div>
		   </div>
	     </div>
	</section>
</div>








<div id="hospital">
	<section id="batch-details">
	  <div class="row-fluid">
	      <div class="span10 billing-form-layout batch-info">
		<div class="span12"> 			<!-- for pages with 2 rows -->
			<div><label for="b_provider"> Billing Provider </label><select id="b_provider" name="bprov" class="input-small combobox"><%= providerSelectionList %></select></div>
			<div><label for="group_no"> Group # </label><input type="text" class="input-mini uneditable-input" placeholder="00000" id="group_no" name="group_no" readonly="true"></div>
			<div><label for="provider"> Provider </label><select id="provider" name="prov" class="input-mini combobox"><%= providerSelectionList %></select></div>
			<div>	<label for="billing-type"> Billing Type </label><select id="billing-type" name="btype" class="input-mini combobox">
				<option value="d1">OHIP</option></select>
			</div>
			<div><label for="location"> Location </label><select id="location" name="loc" class="input-small combobox"><%= clinicSelectionList %></select></div>
			<div>	<label for="billing-center"> Billing Center </label>
				<input type="text" class="input-mini uneditable-input" placeholder="Hamilton" id="billing-center" name="bcenter" readonly="true">
			</div>
			<div><button id="hold" type="submit" class="btn"> Show Hold </button></div>
		</div>
	      </div>
	      <div class="span2 billing-form-layout batch-total">
			<form id="batch-total-form">
				<button id="save-batch" class="btn"> Save Billing </button>
				<label for="batch-total-amt"> Batch Total </label>
				<input id="batch-total-amt" type="text" class="input-small uneditable-input" placeholder="$0.00">
			</form>
	      </div>
	  </div>
	</section>
	<section id="batch-invoices">
	   <div class="row-fluid"><div class="span12">
		<table class="table table-hover table-condense" id="invList">
	  		<thead class="header"><tr><th>Service Start</th><th>Service End</th>
	  		<th>Patient Name</th><th>HCN</th><th>DOB</th><th>Remarks</th><th>Amount</th></tr></thead>
	  		<tbody>
	  		</tbody>
	  	</table>
	   </div></div>
	</section>
	<section id="invoice-detail">
	    <div class="row-fluid">
		   <div id="invoice-demographic" class="span12">
			<input id="demo-name-search" type="text" class="input-medium autocomplete" placeholder="Smith, John" style="margin-left:20%">
			<input id="demo-hin-search" type="text" class="input-small autocomplete" placeholder="1234567890" style="margin-left:7%">
			<input id="demo-dob-search" type="text" class="input-small autocomplete" placeholder="yyyy-mm-dd" style="margin-left:5%">
		   </div>
		   <div id="invoice-status" class="span7">
			<div class="span12">
			     <div class="datepicker" style="width: 150px">
					<label for="admission_date"> Admission date:</label>
						<div id="admission_date" class="input-append">
							<input data-format="yyyy-MM-dd" type="text" placeholder="YYYY-MM-DD" style="width:60%">
							<span class="add-on">
							  <i data-time-icon="icon-time" data-date-icon="icon-calendar">
							  </i>
							</span>
						</div>
			     </div>
			     <div><label for="rdoctor">Referral Doctor</label>
		      		   <select id="rdoctor" class="input-small combobox"><%= pSpecSelectionList%></select>
		      	     </div>
		      	     <div><label for="sli_code"> SLI Code </label>
		      		    <select id="sli_code" class="input-small combobox"><%= sliCodeSelectionList %></select>
		       	     </div>
			</div>
			<div id="dx-space" style="margin-left:30%">
				<div id="dx-header" class="tablerow row-fluid" style=" margin-left:25px">
				     <div class="span2 offset1"> <label for="dx_code"> Dx Code</label> </div>
				     <div class="span3"> Dx Description</div>
				</div>
			</div>
			<div id="dx_master" class="tablerow span12 diagnostic invisible" style="position:absolute; width: 100px">
			     <div class="span1">
	      			<button class="btn invisible" id="delete_Dx" style="position:relative;"><span class='icon-trash'></span></button>
	      		     </div>
			      	<div class="span2"><input type="text" class="autocomplete input-100 dxCode" id="dx_code" data-provide="typeahead" ></div>
			      	<div class="span3"><input type="text" class="autocomplete input-100 dxDesc" id="dx_description" data-provide="typeahead"></div>
			      	<div class="span3"><button class="btn" id="add_Dx">Add Dx</button></div>
			</div>

		   </div>
		   <div id="manual-and-notes" class="span4">
			<div class="form-inline no-label" style="width: 75px; position:relative; top:25px">
				<label for="manualCHK" class="inline"> Manual </label> 
				<input class='inline' type="checkbox" id="manualCHK" style="position:relative; top:-3px">
			</div>
		      	<div class="span10 no-label" style="margin-left:0px"> <input type="text" class="input-100" id="manual_text" readonly="true"></div>
		      	<div class="no-label" style="width: 75px; position:relative; top:25px">
		      		<label for="b_notes">Bill Notes:</label>
		      	</div>
		      	<div class="span10 no-label" style="margin-left:0px">
		      		<input class="input-100" type="text" id="b_notes">
		      	</div>
		   </div>
		  	 <div id="invoice-items" class="span12" style="margin-left:0px; margin-top:30px; width:900px;">
				<div id="items-header" class="row-fluid" style="font-size:1.1em; margin-left:10px">

					<div class="span6">
					   <div class="row-fluid">
					     <div class="span4 offset1"> From </div>
					     <div class="span1" style="position:relative; left:-15px"> Days </div>
					     <div class="span2" style="position:relative; left:-10px"> Code </div>
					     <div class="span4"> Description </div>
					   </div>
					</div>
					<div class="span6" style="margin:0px">
					   <div class="row-fluid" style="padding:0px">
					     <div class="span2"> Amount </div>
					     <div class="span1" style="position:relative; left:-10px"> Units </div>
					     <div class="span2"> Percent</div>
					     <div class="span2"> Total </div>
					   </div>
					</div>

				</div>
				<div id="items-master" class="tablerow row-fluid invisible" style="margin-left:25px; position: absolute;">
					<div class="span6">
						<div class="span1"> <button class="btn" id="delete_item"><span class="icon-trash"></span></button> </div>
						<div class="span4"> 
							<div class="from_date" style="margin-left: 10px;">
								<div id="from_date" class="datepicker">
									<div id="from-date" class="input-append">
										<input data-format="yyyy-MM-dd" type="text"placeholder="YYYY-MM-DD" style="width:70%">
										<span class="add-on">
											<i data-time-icon="icon-time" data-date-icon="icon-calendar">
											</i>
										</span>
									</div>
								</div>
							</div>
					     </div>
					     <div class="span1"> <input type="text" class="input-80" id="days"> </div>
					     <div class="span2" style="position:relative; left:3px"> <input type="text" class="input-80" id="b_code"> </div>
					     <div class="span4"> <input type="text" class="input-80" id="description"> </div>
					</div>
					<div class="span6" style="margin:0px">
					     <div class="span2"> <input type="text" class="input-80" id="amount" readonly="true"> </div>
					     <div class="span1" style="position:relative; left:-3px"> <input type="text" class="input-80" id="units"> </div>
					     <div class="span2"> <input type="text" class="input-80" id="percent" readonly="true"></div>
					     <div class="span3"> <input type='text' class="input-80" id="l_total"> </div>
					     <div class="span2"> <button class="btn" id="add_item"><span class="icon-plus"></span></button> </div>
					</div>
				</div>
				<span id="items-space"> </span>
				<div id="items-footer" class="span12" style="margin: 0px;">
					<div class="span1 offset9" id="total"> $0.00 </div>
				</div>
				<div id="patient-control" class="span12" style="margin: 0px;">
					<div class="span1"><button class="btn" id="prev_patient"><span class="icon-chevron-left"></span></button></div>
					<div class="span10" style="margin:0px"></div>
					<div class="span1"><button class="btn" id="next_patient"><span class="icon-chevron-right"></span></button></div>
				</div>
		  	 </div>

	     </div>
	</section>
</div>












<div id="register" style="height:100%">
	<div class='row' style="height:100%">
		<div class="tabbable span4">
			<ul class="nav nav-tabs" id="billingNav">
				<li><a href="#operations" data-toggle="tab">Operations</a></li>
				<li><a href="#procedures" data-toggle="tab">Procedures</a></li>
				<li><a href="#items" data-toggle="tab">Items</a></li>
				
			</ul>
			
			<div class="tab-content" >
				<div class="tab-pane active" id="operations" style="height:80%">
					
				</div>
				<div class="tab-pane" id="procedures">
					
				 </div>
				<div class="tab-pane" id="items">
					
				</div>
			</div>
		</div>
	
		<div class="span8" style="height:100%;">
			<div class="row-fluid span12">
				<div class="span12">
					<div class="row-fluid" style="padding-left:20px">
						<div class="span3">
							<div id="date" class="search-input datepicker">
								<div id="date" class="input-append">
									<input data-format="yyyy-MM-dd" type="text" class="input-small" placeholder="YYYY-MM-DD">
									<span class="add-on btn">
										  <i data-time-icon="icon-time" data-date-icon="icon-calendar">
										  </i>
									</span>
								</div>
							</div>

						</div>
						<div class="span1 offset8">
							<button class="btn"><span class="icon-print"></span></button>
						</div>
					</div>
				</div>
				<div class="span12">
					<div class="span3">
						<div><label for="b_provider"> Billing Provider </label><select id="b_provider" name="bprov" class="input-small combobox"><%= providerSelectionList %></select></div>
					</div>
					<div class="span3">
						<label>Group</label>
						<input id="group" type="text" class="input-mini" readonly="true" placeholder='00000'>
					</div>

					<div class="span3">
						<div><label for="provider"> Provider </label><select id="provider" name="prov" class="input-small combobox"><%= providerSelectionList %></select></div>
					</div>
				</div>
				<div class="span5">
					<div class="row-fluid">
						<div class="span12">
							<div class="span4">
								<label>Patient Name</label>
							</div>
							<div class="span8">
								<input class="input-100" type="text">
							</div>
							
						</div>
					</div>
					<div class="row-fluid">
						<div class="span12">
							<div class="span4">
								<label>Health Card Number</label>
							</div>
							<div class="span8">
								<input class="input-100" type="text">
							</div>
						</div>
					</div>
					<div class="row-fluid">
						<div class="span12">
							<div class="span4">
								<label>Date of Birth</label>
							</div>
							<div class="span8">
								<input class="input-100" type="text" readonly="true">
							</div>
						</div>
					</div>
					
				</div>
				<div class="span5">
					<div class="row-fluid">
						<div class="span12">
							<div class="span2">
								<label>Address</label>
							</div>
							<div class="span10" style="height:100px;">
								<textarea class="input-100" type="text" style="height:100%; width:100%;" readonly="true"></textarea>			
							</div>
							
						</div>
					</div>
				</div>
				<div class="span12 invoice-details" >
					<div class="span2 offset5">
						<label>
							Invoice Number
						</label>
					</div>
				
					<div class="row-fluid">
						<div class="span12">
							<div class="row-fluid">
								<div class="span1">
									
								</div>
								<div class="span2">
									Item
								</div>
								<div class="span4">
									Description
								</div>
								<div class="span1">
									Amount
								</div>
								<div class="span1">
									Units
								</div>
								<div class="span2">
									Total
								</div>
								<div class="span1">
									
								</div>
							</div>
							<div id='invoice-details-body'>
								<div class="row-fluid invisible item_master" style="display:none;">
									<div class="span1">
										<button class="btn invisible" id="delete_row">
											<span class="icon-minus"></span>
										</button>
									</div>
									<div class="span2">
										<input type="text" id="item" class="input-100">
									</div>
									<div class="span4">
										<input type="text" id="description" class="input-100">
									</div>
									<div class="span1">
										<input type="text" id="amount" class="input-100" readonly="true">
									</div>
									<div class="span1">
										<input type="text" id="units" class="input-100">
									</div>
									<div class="span2">
										<input type="text" id="l_total" class="input-100" readonly="true">
									</div>
									<div class="span1">
										<button class="btn" id="add_row">
											<span class="icon-plus">
											</span>
										</button>
									</div>
								</div>
							</div>
							<div id="invoice-details-footer">
								<div class="row-fluid">
									<div class="offset10 span1">
										<label>
											SUBTOTAL
										</label>
									</div>
									<div class="span1">
										<label id="subtotal">$0.00</label>
									</div>
								</div>
								<div class="row-fluid">
									<div class="offset10 span1">
										<label>
											TAXES
										</label>
									</div>
									<div class="span1">
										<label id="taxes">$0.00</label>
									</div>
								</div>
								<div class="row-fluid">
									<div class="offset10 span1">
										<label>
											TOTAL
										</label>
									</div>
									<div class="span1">
										<label id="total">$0.00</label>
									</div>
								</div>

							</div>
						</div>
					</div>
				</div>
			</div>
				
				
				
				
		</div>
	</div>
</div>

	


</body></html>
