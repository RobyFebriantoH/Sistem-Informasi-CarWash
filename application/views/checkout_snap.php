<html>
  <title>Checkout</title>
  <head>
    <script type="text/javascript" src="https://app.sandbox.midtrans.com/snap/snap.js" data-client-key="SB-Mid-client-NoD7D2wq99bKzHaX"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
  </head>
  <body>
    <form id="payment-form" method="post" action="<?=site_url()?>/snap/finish">
      <input type="hidden" name="result_type" id="result-type" value="" required="Required">
      <input type="hidden" name="result_data" id="result-data" value="" required="Required">
    </form>
    
    <button id="pay-button">Pay!</button>
    
    <script type="text/javascript">
      $('#pay-button').click(function (event) {
        event.preventDefault();
        $(this).attr("disabled", "disabled");

        $.ajax({
          url: '<?=site_url()?>/snap/token',
          cache: false,

          success: function(data) {
            console.log('token = ' + data);

            var resultType = document.getElementById('result-type');
            var resultData = document.getElementById('result-data');

            function changeResult(type, data) {
              $("#result-type").val(type);
              $("#result-data").val(JSON.stringify(data));
            }

            snap.pay(data, {
              onSuccess: function(result) {
                changeResult('success', result);
                console.log(result.status_message);
                console.log(result);
                $("#payment-form").submit();
              },
              onPending: function(result) {
                changeResult('pending', result);
                console.log(result.status_message);
                $("#payment-form").submit();
              },
              onError: function(result) {
                changeResult('error', result);
                console.log(result.status_message);
                // Display error message
                alert('Transaction failed: ' + result.status_message);
                $(this).removeAttr("disabled");
              }
            });
          },
          error: function(xhr, status, error) {
            // Display general error message
            alert('Transaction failed. Please try again later.');
            $(this).removeAttr("disabled");
            location.reload();
            }
          }
        });
      });
    </script>
  </body>
</html>
