(function($) {
	$.widget("ui.checkList", {	
		options: {
			listItems : [],
			selectedItems: [],
			effect: 'blink',
			onChange: {},
			objTable: '',
			icount: 0,
			firstItemChecksAll: true,
			maxDropHeight: 200,
			dropdownlist: '',
		},
		
		_create: function() {
			var self = this, o = self.options, el = self.element;

			// generate outer div
			var container = $('<div/>').addClass('checkList');

			// generate toolbar
			var toolbar = $('<div/>').addClass('toolbar');
			/*var chkAll = $('<input/>').attr('type','checkbox').addClass('chkAll').click(function(){
				var state = $(this).attr('checked');
				var setState = false;
				
				setState = (state==undefined) ? false : true;

				o.objTable.find('.chk:visible').attr('checked', setState);

				self._selChange();
			});*/

			var resultdv = $('<input type="hidden" class="autocompletechecklist-result" />');

			var txtfilter = $('<input/>').attr('type', 'text').addClass('txtFilter').addClass('cz-form-content-input-text').keyup(function () {
				self._filter($(this).val());
			});
			
			var dropdown = $('<div class="cz-form-content-input-select-visible"></div>');
			var dropdownButton = $('<div class="cz-form-content-input-select-visible-button"></div>').click(function () {
				
			    o.objTable.toggle();
			    o.objTable.parent().toggle();
			});

			dropdown.append(dropdownButton);
			//toolbar.append(chkAll);
			toolbar.append($('<div/>').addClass('filterbox').text('').append(txtfilter).append(dropdown));
			toolbar.attr("data-placement", "bottom");
			toolbar.attr("data-trigger", "hover");
			// generate list table object
			o.objTable = $('<table/>').addClass('table');
			o.objTable.hide();
			toolbar.append(resultdv);
			container.append(toolbar);
			var dvTable = $('<div style="overflow:auto;  z-index: 999;     border: 1px solid #ccc;   position: absolute;   height: ' + o.maxDropHeight + 'px;    width: 203px;"></div>');
			dvTable.append(o.objTable);
			dvTable.hide();
			container.append(dvTable);
		
			el.append(container);
			
           if (o.dropdownlist != '') {
               var items = new Array();
               $(o.dropdownlist).css({
                   position: 'absolute',
                   left: "-3300",
                   top: "-3300px",
                   width: '3000px',
                   height: '3000px'
               });
			    $(o.dropdownlist).find("option").map(function () {
			        var item = new Object();
			        item.text = $(this).text();
			        item.value = $(this).val();

			        items.push(item);
			        }).get();
			    o.listItems=items;
           }

          
			self.loadList();
        //    o.objTable.find('.chkAll').attr('checked', true);
         //   o.objTable.find('.chk').attr('checked', true);
           
            //self._selChangeAll();
			
		},

		_addItem: function(listItem){
			var self = this, o = self.options, el = self.element;

			var itemId = 'itm' + (o.icount++);	// generate item id
			var itm = $('<tr/>');

			if (listItem.value != '-1') {
				var chk = $('<input/>').attr('type', 'checkbox').attr('id', itemId)
						.addClass('chk')
						.attr('data-text', listItem.text)
						.attr('data-value', listItem.value);
                	$(chk).click(function () { self._selChange() });
			}
			else {
				var chk = $('<input/>').attr('type', 'checkbox').attr('id', itemId)
						.addClass('chkAll')
						.attr('data-text', listItem.text)
						.attr('data-value', listItem.value);
				$(chk).click(function () { self._selChangeAll() });
            }
				itm.append($('<td/>').append(chk));
				var label = $('<label/>').attr('for',itemId).text(listItem.text);
				itm.append($('<td/>').append(label));
				o.objTable.append(itm);

				// bind selection-change
			
				/*el.delegate('.chk', 'click', function () { self._selChange() });
				if (listItem.value == '-1') {
				    el.delegate('.chkAll', 'click', function () { self._selChangeAll() });
				}*/
				
			
			},

		loadList: function(){
			var self = this, o = self.options, el = self.element;
			//console.log(o.objTable);
			o.objTable.empty();
			$.each(o.listItems,function(){
				//console.log(JSON.stringify(this));
				self._addItem(this);
			});
			o.objTable.find('.chkAll').attr('checked', true);
			o.objTable.find('.chkAll').click();
			o.objTable.find('.chkAll').attr('checked', true);
		},



		_selChange: function(){
			var self = this, o = self.options, el = self.element;

			// empty selection
			o.selectedItems = [];
			var itemTotal = o.listItems.length;
		    // scan elements, find checked ones
			var itemChecked = 0;
			o.objTable.find('.chk').each(function () {

				if($(this).attr('checked')){
					o.selectedItems.push({
						text: $(this).attr('data-text'),
						value: $(this).attr('data-value')
					});
					itemChecked++;
					$(this).parent().addClass('highlight').siblings().addClass('highlight');
				}else{
					$(this).parent().removeClass('highlight').siblings().removeClass('highlight');
				}
				//$(el).find('.ui-dropdownchecklist-result').val(o.selectedItems);
				
			});

			if (itemChecked == (itemTotal - 1))
			{
                o.objTable.find('.chkAll').attr('checked', true);
			    o.objTable.find('.chkAll').click();
			    o.objTable.find('.chkAll').attr('checked', true);

			}

			else {
			    o.objTable.find('.chkAll').attr('checked', false);
			}
			var values = "";
			var i = 0;
			$.each(o.selectedItems, function () {


			    if (i == 0) {
			        values = this.value;
			    }
			    else {
			        values = values + "," + this.value;
			    }
			    i++;
			});
			console.log(o.selectedItems);
			$(o.dropdownlist).find("option").prop("selected", false);
			$.each(values.split(","), function (i, e) {
			    $(o.dropdownlist).find(" option[value='" + e + "']").prop("selected", true);
			});
			// fire onChange event
			//o.onChange.call();
		},

		_selChangeAll: function () {
			var self = this, o = self.options, el = self.element;

			// empty selection
			console.log('event click all');
			o.selectedItems = [];
			var state = el.find('.chkAll').attr('checked');
			var setState = false;

			setState = (state == undefined) ? false : true;
			// scan elements, find checked ones
			o.objTable.find('.chk').attr('checked', setState);

			o.objTable.find('.chkAll').each(function () {

			    if ($(this).attr('checked')) {
			        o.selectedItems.push({
			            text: $(this).attr('data-text'),
			            value: $(this).attr('data-value')
			        });
			        $(this).parent().addClass('highlight').siblings().addClass('highlight');
			    } else {
			        $(this).parent().removeClass('highlight').siblings().removeClass('highlight');
			    }
			});

			o.objTable.find('.chk').each(function () {

				if ($(this).attr('checked')) {
					o.selectedItems.push({
						text: $(this).attr('data-text'),
						value: $(this).attr('data-value')
					});
					$(this).parent().addClass('highlight').siblings().addClass('highlight');
				} else {
					$(this).parent().removeClass('highlight').siblings().removeClass('highlight');
				}


			});
			var values = "";
			var i = 0;
			$.each(o.selectedItems, function () {


			    if (i == 0) {
			        values = this.value;
			    }
			    else {
			        values = values + "," + this.value;
			    }
			    i++;
			});
			console.log(o.selectedItems);
			$(o.dropdownlist).find("option").prop("selected", false);
			$.each(values.split(","), function (i, e) {
			    $(o.dropdownlist).find(" option[value='" + e + "']").prop("selected", true);
			});
			// fire onChange event
			//o.onChange.call();
		},

		_filter: function(filter){
			var self = this, o = self.options, el = self.element;
			
			    
				       
			if (filter.length > 0) {

				if (o.firstItemChecksAll)
				{
					o.objTable.find('.chk').each(function () {
						if ($(this).attr('data-value') == '-1') {
							$(this).parent().parent().show(o.effect);
						}
					});
                }
				o.objTable.find('.chk').each(function () {
					if ($(this).attr('data-value') != '-1') {
						if ($(this).attr('data-text').toLowerCase().indexOf(filter.toLowerCase()) > -1) {

							$(this).parent().parent().show(o.effect);
						}
						else {

							$(this).parent().parent().hide(o.effect);
						}
					}
				    });
				o.objTable.parent().show();
				o.objTable.show();
				
		        }
			    else
			    {
					
					o.objTable.find('.chk').each(function () {
						if ($(this).attr('data-text').toLowerCase().indexOf(filter.toLowerCase()) > -1) {

							$(this).parent().parent().show(o.effect);
						}
						else {

							$(this).parent().parent().hide(o.effect);
						}
					});
					o.objTable.parent().hide();
					o.objTable.hide();
                }
			},

		getSelection: function(){
		    var self = this, o = self.options, el = self.element;

		    if (o.firstItemChecksAll)
		    {
		        var selectAll = false;
		        var objAll = new Array();
		        $.each(o.selectedItems, function () {
		            if(this.value=="-1")
		            {
		                selectAll = true;
		                objAll.push(this);
		            }
		        });
                if(!selectAll)
                {
                    return o.selectedItems;
                }
                else {
                    return objAll;
                }
		    }
		    else {
		        return o.selectedItems;
		    }


			
		},

		getSelection2: function () {
		    var self = this, o = self.options, el = self.element;

		        return o.selectedItems;
		   



		},

		setData: function(dataModel){
			var self = this, o = self.options, el = self.element;
			o.listItems = dataModel;
			self.loadList();
			self._selChange();
		}
	});
})(jQuery); 