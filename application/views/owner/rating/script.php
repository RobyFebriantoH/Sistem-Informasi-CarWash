<script type="text/javascript">
	$(document).ready(function() {
		//show_admin(); //call function show all admin

		$('#mydata').DataTable({
			dom: 'Bfrtip',
			buttons: [
				{
					extend: 'pdfHtml5',
					orientation: 'landscape',
					pageSize: 'LEGAL'
				},
				'copy', 'csv', 'excel', 'print'
			],
			bDestroy: true,
			responsive: true,
		});

	});
</script>
