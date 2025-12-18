<!-- Footer -->
<footer class="content-footer">
    <div>© 2023 Wash - <a href="" target="_blank">Kelompok 38</a></div>
    <div>
        <nav class="nav">
            <a href="https://themeforest.net/licenses/standard" class="nav-link">Licenses</a>
            <a href="#" class="nav-link">Change Log</a>
            <a href="#" class="nav-link">Get Help</a>
        </nav>
    </div>
</footer>
<!-- ./ Footer -->
</div>
<!-- ./ Content body -->
</div>
<!-- ./ Content wrapper -->
</div>
<!-- ./ Layout wrapper -->

<!-- Main scripts -->
<script src="<?= base_url('assets_Owner/'); ?>vendors/bundle.js"></script>

<!-- Apex chart -->
<script src="<?= base_url('assets_Owner/'); ?>vendors/charts/apex/apexcharts.min.js"></script>

<!-- Daterangepicker -->
<script src="<?= base_url('assets_Owner/'); ?>vendors/datepicker/daterangepicker.js"></script>

<!-- Select2 -->
<script src="<?= base_url('assets_Owner/'); ?>vendors/select2/js/select2.min.js"></script>

<!-- Lightbox -->
<script src="<?= base_url('assets_Owner/'); ?>vendors/lightbox/jquery.magnific-popup.min.js"></script>

<!-- Isotope -->
<script src="<?= base_url('assets_Owner/'); ?>vendors/jquery.isotope.min.js"></script>

<script src="<?= base_url('assets_Owner/'); ?>js/examples/pages/gallery.js"></script>

<!-- CKEditor -->
<script src="<?= base_url('assets_Owner/'); ?>vendors/ckeditor5/ckeditor.js"></script>

<!-- DataTable -->
<script src="<?= base_url('assets_Owner/'); ?>vendors/dataTable/datatables.min.js"></script>

<!-- Dashboard scripts -->
<script src="<?= base_url('assets_Owner/'); ?>js/examples/pages/dashboard.js"></script>

<!-- App scripts -->
<script src="<?= base_url('assets_Owner/'); ?>js/app.min.js"></script>
</body>

</html>

<script>
    $('.select2').select2({
        placeholder: 'Select'
    });
</script>

<script>
    $('.image-popup').magnificPopup({
        type: 'image',
        zoom: {
            enabled: true,
            duration: 300,
            easing: 'ease-in-out',
            opener: function(openerElement) {
                return openerElement.is('img') ? openerElement : openerElement.find('img');
            }
        }
    });
</script>

<script>
    ClassicEditor
        .create(document.querySelector('#editor'), {
            toolbar: ['heading', '|', 'bold', 'italic', 'link', 'bulletedList', 'numberedList', 'blockQuote'],
            heading: {
                options: [{
                        model: 'paragraph',
                        title: 'Paragraph',
                        class: 'ck-heading_paragraph'
                    },
                    {
                        model: 'heading1',
                        view: 'h1',
                        title: 'Heading 1',
                        class: 'ck-heading_heading1'
                    },
                    {
                        model: 'heading2',
                        view: 'h2',
                        title: 'Heading 2',
                        class: 'ck-heading_heading2'
                    }
                ]
            }
        })
</script>
