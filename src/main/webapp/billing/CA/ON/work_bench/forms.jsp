<%
	String providerSelectionList = request.getParameter("providers");
	String clinicSelectionList = request.getParameter("locations");
	String superCodeSelectionList = request.getParameter("superCodes");
	String pSpecSelectionList = request.getParameter("rDoctors");
	String sliCodeSelectionList = request.getParameter("sliCodes");
%>

<html><head>
</head><body>

	<div class="workbench" id="dashboard" style="width: 100%;">
		<div class="leftnav">
			<ul class="nav nav-tabs nav-stacked">
			  <li class="navtitle"><a href="#" style="padding:20px">OHIP WORKFLOW</a></li>
			  <li class="active"><a href="#">In Progress <span class="badge"> 10 </span></a></li>
			  <li><a href="#">Ready to Send <span class="badge"> 10 </span></a></li>
			  <li><a href="#">Acknowledge <span class="badge"> 10 </span></a></li>
			  <li><a href="#">Error Correction <span class="badge"> 10 </span></a></li>
			  <li><a href="#">Reconciliation <span class="badge"> 10 </span></a></li>
			</ul>
		</div>
		<div class="panel panel-default rightbody">
			<div id="options" class="panel-heading"> <label for="b_provider"> Billing Provider </label><select id="b_provider" name="bprov" class="input-small combobox"><%= providerSelectionList %></select></div>
			<div id="batch-invoices" class="panel-body" style="padding:0px">
				<table class="table table-striped table-hover table-condensed table-header" id="invList_header">
				<thead>
					<tr>
						<th class="date" style="width: 10%">Serviced</th>
						<th class="time" style="width: 6%">Time</th>
						<th class="patient-name" style="width: 20%">Patient Name</th>
						<th class="health-card-number" style="width: 15%">HCN</th>
						<th class="date-of-birth" style="width: 10%">DOB</th>
						<th class="bill_date">Bill Date</th>
						<th class="ver" style="width: 7%">Version</th>
						<th class="age" style="width: 5%">Age</th>
						<th class="amount" style="width: 6%">Amount</th>
					</tr>
				</thead>
				</table>
				<div id="invList_body_container" class="bodycontainer scrollable" style="height:150px">
					<table id="invList_body" class="table table-hover table-striped table-condensed table-scrollable">
						<tbody>
							<td style="text-align: center"> No items: Please choose query attributes above</td>
						</tbody>
					</table>
				</div>
				<div id="detail-trigger" class="condense" style="background-color: #DDDDDD; text-align: center; padding:5px"> Less Detail <i class="icon-chevron-down"></i> </div>
				<div id="detail" class="row-fluid" style="height:150px; background-color: #EEEEEE;">
					<div class="span5 bodycontainer scrollable" style="margin-left: 75px;">
						<table>
							<tr><th colspan="2"><b><u>Summary</u></b></th></tr>
							<tr><td>Created By:</td><td>Me, Iamme</td></tr>
							<tr><td>Something:</td><td>I dunno</td></tr>
							<tr><td>Total:</td><td>105.29</td></tr>
						</table>
					</div>
					<div class="span5 bodycontainer scrollable">
						<table>
							<tr><th colspan="2"><b><u>Edit History</u></b></th></tr>
							<tr><td>Created By:</td><td>Me, Iamme</td></tr>
							<tr><td>Something:</td><td>I dunno</td></tr>
							<tr><td>Total:</td><td>105.29</td></tr>
						</table>
					</div>
				</div>
			</div>
			<div id="invoice-detail" class="panel-footer" style="margin: 0px">
				<div class="row-fluid">
					<div id="invoice-status" class="span8">
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
							<div>
								<label for="rdoctor">Referral Doctor</label>
								<select id="rdoctor" class="input-small combobox"><%= pSpecSelectionList%></select>
							</div>
							<div class="inv-prop"><label for="billing-type"> Billing Type </label>
								<select id="billing-type" name="btype" class="input-mini combobox"><option value="OHIP">OHIP</option><option value="RMB">RMB</option></select>
							</div>
							<div>
								<label for="sli_code"> SLI Code </label>
								<select id="sli_code" class="input-small combobox"><%= sliCodeSelectionList %></select>
							</div>
						</div>
					</div>
					<div id="manual-and-notes" class="span4">
						<div class="form-inline no-label" style="width: 75px;">
							<label for="manualCHK" class="inline"> Manual </label> 
							<input class='inline' type="checkbox" id="manualCHK" style="position:relative; top:-3px">
						</div>
						<div class="span11 no-label" style="margin-left:0px"> <input type="text" class="input-100" id="manual_text" readonly="true"></div>
						<div class="no-label" style="width: 75px;"><label for="b_notes">Bill Notes:</label></div>
						<div class="span11 no-label" style="margin-left:0px"><input class="input-100" type="text" id="b_notes"></div>
					</div>
					<div id="invoice-items" class="span12" style="margin-left:0px; margin-top:30px; width:750px;">
						<div id="items-header" class="row-fluid" style="font-size:1.1em; margin-left:10px">
							<div class="span7">
								<div class="row-fluid">
									<div class="span4 offset1" style="position:relative; left:-15px"> From </div>
									<div class="span1" style="position:relative; left:-20px"> Days </div>
									<div class="span2" style="position:relative; left:-15px"> Code </div>
									<div class="span4" style="position:relative; left:-15px"> Description </div>
								</div>
							</div>
							<div class="span5" style="margin:0px">
								<div class="row-fluid" style="padding:0px">
									<div class="span2" style="position:relative; left:-25px"> Amount </div>
									<div class="span2" style="position:relative; left:-10px"> Units </div>
									<div class="span2" style="position:relative; left:-15px"> Percent</div>
									<div class="span2" style="position:relative; left:-15px"> Total </div>
								</div>
							</div>
						</div>
						<div id="items-master" class="tablerow row-fluid invisible" style="margin-left:25px; position: absolute;">
							<div class="span7">
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
							<div class="span5" style="margin:0px">
								 <div class="span2" style="position:relative; left:-5px"> <input type="text" class="input-80" id="amount" readonly="true"> </div>
								 <div class="span2" style="position:relative; left:-3px"> <input type="text" class="input-80" id="units"> </div>
								 <div class="span2"> <input type="text" class="input-80" id="percent" readonly="true"></div>
								 <div class="span3"> <input type='text' class="input-80" id="l_total"> </div>
								 <div class="span2"> <button class="btn" id="add_item"><span class="icon-plus"></span></button> </div>
							</div>
						</div>
						<span id="items-space"> </span>
						<div id="items-footer" class="span5 offset7" style="margin-top:20px">
							<button type="button" class="btn">Hold</button>
							<button type="button" class="btn">EBM History</button>
							<button type="button" class="btn">Submit</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body></html>
