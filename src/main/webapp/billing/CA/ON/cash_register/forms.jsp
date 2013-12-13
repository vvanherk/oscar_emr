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
