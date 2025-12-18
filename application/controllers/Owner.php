<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Owner extends CI_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->model('OwnerModel');

        $this->load->library('form_validation');
    }

    public function index()
    {

        if ($this->session->userdata('is_Owner') == TRUE) {
            redirect('Owner/securepage', 'refresh');
        }

        $this->load->view('Owner/login/form_login');
    }

    //register
    public function register()
    {

        if ($this->session->userdata('is_Owner') == TRUE) {
            redirect('Owner/securepage', 'refresh');
        }

        $this->load->view('Owner/register/form_register');
    }

    public function register_proses()
    {

        $this->form_validation->set_rules('nama', 'Nama', 'trim|required|min_length[3]|max_length[22]');
        $this->form_validation->set_rules('email', 'E-mail', 'trim|required|min_length[3]|max_length[45]|is_unique[Owner.email]');
        $this->form_validation->set_rules('password', 'Password', 'trim|required|min_length[5]');

        if ($this->form_validation->run() == TRUE) {

            if ($this->OwnerModel->register()) {

                $this->session->set_flashdata('success', 'Register berhasil, silahkan  Sign In.');
                redirect('Owner/', 'refresh');
            } else {

                $this->session->set_flashdata('error', 'Register Owner gagal!');
                redirect('Owner/', 'refresh');
            }
        } else {

            $this->load->view('Owner/register/form_register');
        }
    }

    //login
    public function login_proses()
    {

        $this->form_validation->set_rules('email', 'E-mail', 'trim|required|min_length[3]|max_length[45]');
        $this->form_validation->set_rules('password', 'Password', 'trim|required|min_length[5]');

        if ($this->form_validation->run() == TRUE) {

            if ($this->OwnerModel->cek_mail()->num_rows() == 1) {

                $db = $this->OwnerModel->cek_mail()->row();
                if (hash_verified($this->input->post('password'), $db->password)) {

                    $data_login = array(
                        'is_Owner' => TRUE,
                        'email'  => $db->email,
                        'nama'   => $db->nama,
                        'id'   => $db->id
                    );

                    $this->session->set_userdata($data_login);
                    redirect('Owner/securepage', 'refresh');
                } else {

                    $this->session->set_flashdata('error', 'Login gagal: password salah!');
                    redirect('Owner/', 'refresh');
                }
            } else { // jika email tidak terdaftar!

                $this->session->set_flashdata('error', 'Login gagal: email salah!');
                redirect('Owner/', 'refresh');
            }
        } else {

            $this->load->view('Owner/login/form_login');
        }
    }


    public function securepage()
    {

        if ($this->session->userdata('is_Owner') == FALSE) {
            redirect('Owner/', 'refresh');
        }

        $data['title'] = 'Dashboard';
        $data['Owner'] = $this->OwnerModel->data_Owner();
        $data['saldo_bulan'] = $this->OwnerModel->saldo_bulan();
        $data['saldo_total'] = $this->OwnerModel->saldo_total();
        $data['perbandingan'] = $this->OwnerModel->perbandingan();
        $data['perbandingan_pendapatan'] = $this->OwnerModel->perbandingan_pendapatan();
        $data['pendapatan_mobil_besar'] = $this->OwnerModel->pendapatan_mobil_besar();
        $data['pendapatan_mobil_kecil'] = $this->OwnerModel->pendapatan_mobil_kecil();
        $data['pendapatan_bulan_ini'] = $this->OwnerModel->pendapatan_bulan_ini();
        $data['pendapatan_bulan_lalu'] = $this->OwnerModel->pendapatan_bulan_lalu();

		$this->db->select('r.id_rating, r.rating, r.feedback, r.order_id, k.id_pelanggan id_pelanggan, k.nama nama_pelanggan, k.id_tempat_cuci, d.id id_tempat, d.nama nama_tempat');
		$this->db->from('rating r');
		$this->db->join('transaksi k', 'r.order_id = k.order_id');
		$this->db->join('tempat_cuci d', 'k.id_tempat_cuci = d.id');
		$this->db->order_by('r.id_rating', 'desc');
		$this->db->limit(5);
		$query = $this->db->get();
		$data['rating'] = $query->result();

		$data['transaksi'] = $this->db->query("SELECT tw.order_id, tw.gross_amount, tw.payment_type, tw.transaction_time, tw.bank, tw.va_number,
                tw.pdf_url, tw.status_code, tw.kendaraan,tw.deskripsi_mobil, tw.tanggal_pesan, tw.id_pelanggan, tw.nama, tw.alamat, tw.email, tw.no_hp,
                tw.id_tempat_cuci, w.nama nama_usaha, w.foto1 foto1
                FROM transaksi tw 
                JOIN tempat_cuci w 
                ON tw.id_tempat_cuci = w.id
				WHERE tw.status_code != 202 
                ORDER BY transaction_time DESC LIMIT 5")->result();

        $this->load->view('Owner/layout/header', $data);
        $this->load->view('Owner/layout/sidebar', $data);
        $this->load->view('Owner/index', $data);
        $this->load->view('Owner/layout/footer', $data);
        $this->load->view('Owner/layout/script', $data);
    }

    public function logout()
    {

        $this->session->unset_userdata('is_Owner');
        $this->session->unset_userdata('nama');
        $this->session->unset_userdata('email');
        $this->session->unset_userdata('id');

        session_destroy();
        $this->session->set_flashdata('success', 'Sign Out Berhasil!');
        redirect('Owner/', 'refresh');
    }


    //pelanggan
    function pelanggan()
    {
        if ($this->session->userdata('is_Owner') == FALSE) {
            redirect('Owner/', 'refresh');
        }

        $data['title'] = 'Data Pelanggan';
        $data['Owner'] = $this->OwnerModel->data_Owner();
		$data['pelanggan'] = $this->OwnerModel->pelanggan_list();

        $this->load->view('Owner/layout/header', $data);
        $this->load->view('Owner/layout/sidebar', $data);
        $this->load->view('Owner/pelanggan/index', $data);
        $this->load->view('Owner/layout/footer', $data);
        $this->load->view('Owner/pelanggan/script', $data);
    }

    function pelanggan_data()
    {
        $data = $this->OwnerModel->pelanggan_list();
		echo json_encode($data);
        //$this->output->set_content_type('application/json')->set_output(json_encode($data));
    }

    function banned_pelanggan()
    {
        $data = $this->OwnerModel->banned_pelanggan();
		//echo json_encode($data);
		redirect('Owner/pelanggan');
        //$this->output->set_content_type('application/json')->set_output(json_encode($data));
    }

    function aktif_pelanggan()
    {
        $data = $this->OwnerModel->aktif_pelanggan();
		//echo json_encode($data);
		redirect('Owner/pelanggan');
        //$this->output->set_content_type('application/json')->set_output(json_encode($data));
    }

    //admin
    function admin()
    {
        if ($this->session->userdata('is_Owner') == FALSE) {
            redirect('Owner/', 'refresh');
        }

        $data['title'] = 'Data admin';
        $data['Owner'] = $this->OwnerModel->data_Owner();
		$data['admin'] = $this->OwnerModel->admin_list();

        $this->load->view('Owner/layout/header', $data);
        $this->load->view('Owner/layout/sidebar', $data);
        $this->load->view('Owner/admin/index', $data);
        $this->load->view('Owner/layout/footer', $data);
        $this->load->view('Owner/admin/script', $data);
    }

    function admin_data()
    {
        $data = $this->OwnerModel->admin_list();
        $this->output->set_content_type('application/json')->set_output(json_encode($data));
    }

    function banned_admin()
    {
        $data = $this->OwnerModel->banned_admin();
        redirect('Owner/admin', 'refresh');
    }

    function aktif_admin()
    {
        $data = $this->OwnerModel->aktif_admin();
        redirect('Owner/admin', 'refresh');
    }

    //tempat cuci
    function tempat_cuci()
    {
        if ($this->session->userdata('is_Owner') == FALSE) {
            redirect('Owner/', 'refresh');
        }

        $data['title'] = 'Data Tempat Cuci';
        $data['Owner'] = $this->OwnerModel->data_Owner();
		$data['tempat_cuci'] = $this->OwnerModel->tempat_cuci_list();

        $this->load->view('Owner/layout/header', $data);
        $this->load->view('Owner/layout/sidebar', $data);
        $this->load->view('Owner/tempat_cuci/index', $data);
        $this->load->view('Owner/layout/footer', $data);
        $this->load->view('Owner/tempat_cuci/script', $data);
    }

    function tempat_cuci_data()
    {
        $data = $this->OwnerModel->tempat_cuci_list();
        $this->output->set_content_type('application/json')->set_output(json_encode($data));
    }

    //transaksi
    function transaksi()
    {
        if ($this->session->userdata('is_Owner') == FALSE) {
            redirect('Owner/', 'refresh');
        }

        $data['title'] = 'Data Transaksi';
        $data['Owner'] = $this->OwnerModel->data_Owner();
        $data['transaksi'] = $this->db->query("SELECT tw.order_id, tw.gross_amount, tw.payment_type, tw.transaction_time, tw.bank, tw.va_number,
                tw.pdf_url, tw.status_code,tw.status, tw.kendaraan,tw.deskripsi_mobil, tw.tanggal_pesan, tw.id_pelanggan, tw.nama, tw.alamat, tw.email, tw.no_hp,
                tw.id_tempat_cuci, w.nama nama_usaha, w.foto1 foto1
                FROM transaksi tw 
                JOIN tempat_cuci w 
                ON tw.id_tempat_cuci = w.id
                WHERE tw.status_code != 201 AND tw.status != 1 AND tw.status != 2
                ORDER BY transaction_time DESC")->result();

        $this->load->view('Owner/layout/header', $data);
        $this->load->view('Owner/layout/sidebar', $data);
        $this->load->view('Owner/transaksi/index', $data);
        $this->load->view('Owner/layout/footer', $data);
        $this->load->view('Owner/transaksi/script', $data);
    }

	function transaksi_aktif()
	{
		if ($this->session->userdata('is_Owner') == FALSE) {
			redirect('Owner/', 'refresh');
		}

		$data['title'] = 'Data Transaksi Aktif';
		$data['Owner'] = $this->OwnerModel->data_Owner();
		$data['transaksi'] = $this->db->query("SELECT tw.order_id, tw.gross_amount, tw.payment_type, tw.transaction_time, tw.bank, tw.va_number,
                tw.pdf_url, tw.status_code,tw.status, tw.kendaraan,tw.deskripsi_mobil, tw.tanggal_pesan, tw.id_pelanggan, tw.nama, tw.alamat, tw.email, tw.no_hp,
                tw.id_tempat_cuci, w.nama nama_usaha, w.foto1 foto1
                FROM transaksi tw 
                JOIN tempat_cuci w 
                ON tw.id_tempat_cuci = w.id
				WHERE tw.status_code != 202 AND tw.status != 3
                ORDER BY transaction_time DESC")->result();

		$this->load->view('Owner/layout/header', $data);
		$this->load->view('Owner/layout/sidebar', $data);
		$this->load->view('Owner/transaksi/index_aktif', $data);
		$this->load->view('Owner/layout/footer', $data);
		$this->load->view('Owner/transaksi/script', $data);
	}

    function transaksi_data()
    {
        $data = $this->OwnerModel->transaksi_list();
        $this->output->set_content_type('application/json')->set_output(json_encode($data));
    }

    //faq
    function faq()
    {
        if ($this->session->userdata('is_Owner') == FALSE) {
            redirect('Owner/', 'refresh');
        }

        $data['title'] = 'F.A.Q.';
        $data['Owner'] = $this->OwnerModel->data_Owner();
		$data['faq'] = $this->OwnerModel->faq_list();

        $this->load->view('Owner/layout/header', $data);
        $this->load->view('Owner/layout/sidebar', $data);
        $this->load->view('Owner/faq/index', $data);
        $this->load->view('Owner/layout/footer', $data);
        $this->load->view('Owner/faq/script', $data);
    }

    function faq_data()
    {
        $data = $this->OwnerModel->faq_list();
        $this->output->set_content_type('application/json')->set_output(json_encode($data));
    }

    function save_faq()
    {
        $data = $this->OwnerModel->save_faq();
        redirect('Owner/faq', 'refresh');
    }

    function update_faq()
    {
        $data = $this->OwnerModel->update_faq();
		redirect('Owner/faq', 'refresh');
    }

    function delete_faq()
    {
        $data = $this->OwnerModel->delete_faq();
		redirect('Owner/faq', 'refresh');
    }


    //profile
    function profile()
    {
        if ($this->session->userdata('is_Owner') == FALSE) {
            redirect('Owner/', 'refresh');
        }

        $data['title'] = 'Profile';
        $data['Owner'] = $this->OwnerModel->data_Owner();

        $this->load->view('Owner/layout/header', $data);
        $this->load->view('Owner/layout/sidebar', $data);
        $this->load->view('Owner/profile/index', $data);
        $this->load->view('Owner/layout/footer', $data);
        $this->load->view('Owner/profile/script', $data);
    }

    function get_data()
    {
        $data = $this->OwnerModel->getData();
        $this->output->set_content_type('application/json')->set_output(json_encode($data));
    }

    function get_single($id)
    {
        $data = $this->OwnerModel->getById($id);
        $this->output->set_content_type('application/json')->set_output(json_encode($data));
    }

    function _validate()
    {
        $this->form_validation->set_error_delimiters('', '');
        $this->form_validation->set_rules('nama', 'Nama', 'trim|required|min_length[2]|max_length[50]');
        $this->form_validation->set_rules('email', 'Email', 'trim|required|min_length[2]|max_length[50]');
        if (empty($_FILES['file']['name'])) {
            $this->form_validation->set_rules('file', 'Foto', 'required');
        }
    }

    function _config()
    {
        $config['upload_path']      = "./uploads/Owner";
        $config['allowed_types']    = 'gif|jpg|jpeg|png';
        $config['encrypt_name']     = TRUE;

        $this->load->library('upload', $config);
    }

    function do_upload()
    {
        $this->_validate();
        $this->_config();

        $nama = $this->input->post('nama');
        $email = $this->input->post('email');

        if ($this->form_validation->run() == FALSE || $this->upload->do_upload("file") == FALSE) {
            $errors = array(
                'file'            => form_error('file'),
                'nama'         => form_error('nama'),
                'email'         => form_error('email'),
                'fail_upload'     => $this->upload->display_errors('', '')
            );
            $data = array(
                'errors' => $errors,
                'status' => false
            );
            $this->output->set_content_type('application/json')->set_output(json_encode($data));
        }
    }

    function edit()
    {
        $id = $this->input->post('id');
        $img_data = $this->OwnerModel->getById($id);
        $img_src = FCPATH . 'uploads/Owner/' . $img_data->foto;

        $nama = $this->input->post('nama');
        $email = $this->input->post('email');

        if ($_FILES['file']['name'] == '') {
            $this->form_validation->set_error_delimiters('', '');
            $this->form_validation->set_rules('nama', 'Nama', 'trim|required|min_length[2]|max_length[50]');
            $this->form_validation->set_rules('email', 'Email', 'trim|required|min_length[2]|max_length[50]');

            if ($this->form_validation->run()) {
                $this->OwnerModel->update($id, $nama, $email, null);
                $this->output->set_content_type('application/json')->set_output(json_encode(array('status' => true)));
            } else {
                $errors['nama'] = form_error('nama');
                $errors['email'] = form_error('email');
                $data = array(
                    'errors' => $errors,
                    'status' => false
                );
                $this->output->set_content_type('application/json')->set_output(json_encode($data));
            }
        } else {
            $this->_validate();
            $this->_config();
            if ($this->form_validation->run() == FALSE || $this->upload->do_upload("file") == FALSE) {
                $errors = array(
                    'file'            => form_error('file'),
                    'nama'         => form_error('nama'),
                    'email'         => form_error('email'),
                    'fail_upload'     => $this->upload->display_errors('', '')
                );
                $data = array(
                    'errors' => $errors,
                    'status' => false
                );
                $this->output->set_content_type('application/json')->set_output(json_encode($data));
            } else {
                $data = array('upload_data' => $this->upload->data());
                $image = $data['upload_data']['file_name'];

                if ($img_data->foto == 'avatar.jpg') {
                    $this->OwnerModel->update($id, $nama, $email, $image);
                    $this->output->set_content_type('application/json')->set_output(json_encode(array('status' => true)));
                } else {

                    if (unlink($img_src)) {
                        $this->OwnerModel->update($id, $nama, $email, $image);
                        $this->output->set_content_type('application/json')->set_output(json_encode(array('status' => true)));
                    }
                }
            }
        }
    }

    //password


    function edit_password()
    {
        $id = $this->session->userdata('id');

        $password = $this->input->post('password');

        $this->form_validation->set_error_delimiters('', '');
        $this->form_validation->set_rules('password', 'Password', 'trim|required|min_length[5]');

        if ($this->form_validation->run()) {
            $this->OwnerModel->updatePassword($id, $password);
            $this->session->set_flashdata('error', 'Edit Password Berhasil!');
            redirect('Owner/profile', 'refresh');
        } else {
            $this->session->set_flashdata('error', 'Edit Password Gagal!');
            redirect('Owner/profile', 'refresh');
        }
    }

	//rating
	public function rating()
	{
		if ($this->session->userdata('is_Owner') == FALSE) {
			redirect('Owner/', 'refresh');
		}

		$data['title'] = 'Data Rating';
		$data['Owner'] = $this->OwnerModel->data_Owner();

		$this->db->select('r.id_rating, r.rating, r.feedback, r.order_id, k.id_pelanggan id_pelanggan, k.nama nama_pelanggan, k.id_tempat_cuci, d.id id_tempat, d.nama nama_tempat, r.status');
		$this->db->from('rating r');
		$this->db->join('transaksi k', 'r.order_id = k.order_id');
		$this->db->join('tempat_cuci d', 'k.id_tempat_cuci = d.id');
		$query = $this->db->get();
		$data['rating'] = $query->result();

		$this->load->view('Owner/layout/header', $data);
		$this->load->view('Owner/layout/sidebar', $data);
		$this->load->view('Owner/rating/index', $data);
		$this->load->view('Owner/layout/footer', $data);
		$this->load->view('Owner/rating/script', $data);
	}

	function banned_rating()
	{
		$data = $this->OwnerModel->banned_rating();
		//echo json_encode($data);
		redirect('Owner/rating', 'refresh');
		//$this->output->set_content_type('application/json')->set_output(json_encode($data));
	}

	function aktif_rating()
	{
		$data = $this->OwnerModel->aktif_rating();
		//echo json_encode($data);
		redirect('Owner/rating', 'refresh');
		//$this->output->set_content_type('application/json')->set_output(json_encode($data));
	}
}
