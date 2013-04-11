$("div.query-builder").html("<%= escape_javascript render partial: 'query_builder',locals:{fact:@fact, dims:@dims} %>");
