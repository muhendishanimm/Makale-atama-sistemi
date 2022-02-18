package makaleler;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import makaleler.VeriBilgileri;
import java.util.ArrayList;
import java.util.List;
import com.mysql.cj.xdevapi.Collection;


import java.sql.*;

public class VeriIslemler {
	private Connection con;
	private String driver="com.mysql.jdbc.Driver";
	private String url="jdbc:mysql://127.0.0.1:3306/makalesistemi?characterEncoding=ISO-8859-9"; //useUnicode=true&characterEncoding=UTF-8
	private Statement stm;
	private ResultSet resultSet = null;
	//hocalar
	private String EditorKullaniciAdi;
	private String EditorSifre;
	private String HocaKullaniciAdi;
	private String HocaSifre;
	private String HocaMail;
	private String HocaAdSoyad;
	private String HocaTarih;
	private String Puan;
	private String Pozisyon;
	private int KtgId;
	//makale
	private String Baslik;
	private String Icerik;
	private String Tarih;
	private String Yazari;
	private String Durum;
	private String DegerlendirenHoca;
	private int KategoriId;
	//yazarlar
	private String YzrKullaniciAdi;
	private String YzrSifre;
	private String YzrMail;
	private String YzrAdSoyad;
	private String YazarTarih;
	private int KtgIdsi;
	
	public VeriIslemler()
	{
		try { 
			Class.forName(driver); 
		   System.out.println("JDBC surucu basari ile yüklendi.");
		}
		catch (Exception e) 
		{ 
			System.out.println("JDBC surucu Yüklenemedi. Hata:"+e.getMessage()); System.exit(0); 
		}
		try{
			con=DriverManager.getConnection(url,"root","123456");System.out.println("Veritabanýna baðlanýldý.");
			}
		catch (Exception e) { 
			System.out.println("Veri Tabanýna Baðlanýlamadý. Hata:"+e.getMessage()); System.exit(0);
			}
		try {
			stm=con.createStatement();
			}
		catch (Exception e) { 
				System.out.println("Hata:"+e.getMessage()); System.exit(0); 
		
			}
	}
//EDÝTOR ÝÞLEMLERÝ	
//***Editör Listeleme
	public ResultSet editorlistesi()
	{		
		try
		{
			        CallableStatement stm=(CallableStatement) con.prepareCall("{call editorlistesi()}");
					boolean hasResult =stm.execute();
					if(hasResult){
					ResultSet res=stm.getResultSet();
					System.out.println("Listeleme Baþarýlý");
					return res;
					}
					else 
					   return null;
					}
		catch (Exception e) 
		{ 
			System.out.println("Hata:"+e.getMessage());	
		}
		return resultSet;
	}
//editor bilgisini günceleme
	public boolean editorguncelle(VeriBilgileri editor,int id)
	{
        String EditorMail=editor.getEditorMail();
        String EditorSifre=editor.getEditorSifre();	
        String EditorTarih=editor.getEditorTarih();	
		
		try
		{
			
			CallableStatement statement=(CallableStatement) con.prepareCall("{call editorguncelle(?,?,?,?)}");
			 statement.setInt(1,id);
			 statement.setString(2,EditorMail);	
			 statement.setString(3,EditorSifre);	
			 statement.setString(4,EditorTarih);	
			 int result=statement.executeUpdate();
			 if(result>0)
			 {
				 System.out.println("editor bilgileri Güncellendi");
				 return true;
			 }
			 else
			 { 
				 return false;
			 }
		}
		catch (Exception e) { 
			System.out.println("Hata:"+e.getMessage()); 
			return false;
		}
	}
//YAZAR ÝÞLEMLERÝ	
//***Yazar Listeleme	
	public ResultSet yazarlistesi()
	{		
		try
		{
			        CallableStatement stm=(CallableStatement) con.prepareCall("{call yazarlistesi()}");
					boolean hasResult =stm.execute();
					if(hasResult){
					ResultSet res=stm.getResultSet();
					System.out.println("Listeleme Baþarýlý");
					return res;
					}
					else 
					   return null;
					}
		catch (Exception e) 
		{ 
			System.out.println("Hata:"+e.getMessage());	
		}
		return resultSet;
	}
//yazarselectall
	public ResultSet yazarselectall()
	{		
		try
		{
			        CallableStatement stm=(CallableStatement) con.prepareCall("{call yazarselectall()}");
					boolean hasResult =stm.execute();
					if(hasResult){
					ResultSet res=stm.getResultSet();
					System.out.println("Listeleme Baþarýlý");
					return res;
					}
					else 
					   return null;
					}
		catch (Exception e) 
		{ 
			System.out.println("Hata:"+e.getMessage());	
		}
		return resultSet;
	}
//yazar ekle
	public boolean yazarekle(VeriBilgileri yazar)
	{
		YzrKullaniciAdi=yazar.getYzrKullaniciAdi();
		YzrSifre=yazar.getYzrSifre();
		YzrMail=yazar.getYzrMail();
		YzrAdSoyad=yazar.getYzrAdSoyad();
		YazarTarih=yazar.getYazarTarih();
	    KtgIdsi=yazar.getKtgIdsi();
		try {
		 CallableStatement Cs;
	     Cs=(CallableStatement) con.prepareCall("{call yazarekle(?,?,?,?,?,?)}");  
	     Cs.setString(1, YzrKullaniciAdi);
	     Cs.setString(2, YzrSifre);
	     Cs.setString(3, YzrMail);
	     Cs.setString(4, YzrAdSoyad);
	     Cs.setString(5, YazarTarih);
	     Cs.setInt(6, KtgIdsi);
	     Cs.execute();
	     return true;
	     }
		catch(Exception e) {
			System.out.println("Hata:"+e.getMessage());
			return false;
		}
	}
//yazar bilgi guncelle
	public boolean yazarguncelle(VeriBilgileri yazar,int id)
	{
        String YzrMail=yazar.getYzrMail();
        String YzrSifre=yazar.getYzrSifre();	
        String YazarTarih=yazar.getYazarTarih();	
		
		try
		{
			
			CallableStatement statement=(CallableStatement) con.prepareCall("{call yazarguncelle(?,?,?,?)}");
			 statement.setInt(1,id);
			 statement.setString(2,YzrMail);	
			 statement.setString(3,YzrSifre);	
			 statement.setString(4,YazarTarih);	
			 int result=statement.executeUpdate();
			 if(result>0)
			 {
				 System.out.println("yazar bilgileri Güncellendi");
				 return true;
			 }
			 else
			 { 
				 return false;
			 }
		}
		catch (Exception e) { 
			System.out.println("Hata:"+e.getMessage()); 
			return false;
		}
	}
	public boolean yazarSifreguncelle(VeriBilgileri yazar,String YzrMail)
	{
 
        String YzrSifre=yazar.getYzrSifre();	
        String YazarTarih=yazar.getYazarTarih();	
		
		try
		{
			
			CallableStatement statement=(CallableStatement) con.prepareCall("{call yazarSifreguncelle(?,?,?)}");
			 statement.setString(1,YzrMail);	
			 statement.setString(2,YzrSifre);	
			 statement.setString(3,YazarTarih);	
			 int result=statement.executeUpdate();
			 if(result>0)
			 {
				 System.out.println("yazar þifresi Güncellendi");
				 return true;
			 }
			 else
			 { 
				 return false;
			 }
		}
		catch (Exception e) { 
			System.out.println("Hata:"+e.getMessage()); 
			return false;
		}
	}
//HOCA ÝÞLEMLERÝ
//***Hoca Listeleme
	public ResultSet hocalistesi()
	{		
		try
		{
			        CallableStatement stm=(CallableStatement) con.prepareCall("{call hocalistesi()}");
					boolean hasResult =stm.execute();
					if(hasResult){
					ResultSet res=stm.getResultSet();
					System.out.println("Listeleme Baþarýlý");
					return res;
					}
					else 
					   return null;
					}
		catch (Exception e) 
		{ 
			System.out.println("Hata:"+e.getMessage());	
		}
		return resultSet;
	}
//hoca selectall
	public ResultSet hocaselectall()
	{		
		try
		{
			        CallableStatement stm=(CallableStatement) con.prepareCall("{call hocaselectall()}");
					boolean hasResult =stm.execute();
					if(hasResult){
					ResultSet res=stm.getResultSet();
					System.out.println("Listeleme Baþarýlý");
					return res;
					}
					else 
					   return null;
					}
		catch (Exception e) 
		{ 
			System.out.println("Hata:"+e.getMessage());	
		}
		return resultSet;
	}
//hoca ekleme
			public boolean hocaekle(VeriBilgileri hoca) {
			 HocaKullaniciAdi=hoca.getHocaKullaniciAdi();
			 HocaSifre=hoca.getHocaSifre();
			 HocaAdSoyad=hoca.getHocaAdSoyad();
			 HocaMail=hoca.getHocaMail();
			 Puan=hoca.getPuan();
			 Pozisyon=hoca.getPozisyon();
			 HocaTarih=hoca.getHocaTarih();
		     KtgId=hoca.getKtgId();
	 	    try {
		     CallableStatement Cs;
		     Cs=(CallableStatement) con.prepareCall("{call hocaekle(?,?,?,?,?,?,?,?)}");
		     Cs.setString(1, HocaKullaniciAdi);
		     Cs.setString(2, HocaSifre);
		     Cs.setString(3, HocaAdSoyad);
		     Cs.setString(4, HocaMail);
		     Cs.setString(5, Puan);
		     Cs.setString(6, Pozisyon);
		     Cs.setString(7, HocaTarih);
		     Cs.setInt(8, KtgId);	     
		     Cs.execute();
		     return true;
		}
			 catch (Exception e) 
				{ 
			System.out.println("Hata:"+e.getMessage());	
			return false;
		}
			 }
//hoca pozisyon guncelle
			public boolean hocapozisyonguncelle(VeriBilgileri hoca,int id)
			{
	            String Pozisyon=hoca.getPozisyon();	
				try
				{
					
					CallableStatement statement=(CallableStatement) con.prepareCall("{call hocapozisyonguncelle(?,?)}");
					 statement.setInt(1,id);
					 statement.setString(2,Pozisyon);						
					 int result=statement.executeUpdate();
					 if(result>0)
					 {
						 System.out.println("hoca pozisyon Güncellendi");
						 return true;
					 }
					 else
					 { 
						 return false;
					 }
				}
				catch (Exception e) { 
					System.out.println("Hata:"+e.getMessage()); 
					return false;
				}
			}
			public boolean hocapozisyongeri(VeriBilgileri hoca,String HocaAdSoyad)
			{
	            String Pozisyon=hoca.getPozisyon();	
				try
				{
					
					CallableStatement statement=(CallableStatement) con.prepareCall("{call hocapozisyongeri(?,?)}");
					 statement.setString(1,HocaAdSoyad);
					 statement.setString(2,Pozisyon);						
					 int result=statement.executeUpdate();
					 if(result>0)
					 {
						 System.out.println("hoca pozisyon geri Güncellendi");
						 return true;
					 }
					 else
					 { 
						 return false;
					 }
				}
				catch (Exception e) { 
					System.out.println("Hata:"+e.getMessage()); 
					return false;
				}
			}
//hoca sil
			public boolean hocasil(int id)
			{
				try
				{	
					CallableStatement statement=(CallableStatement) con.prepareCall("{call hocasil(?)}");
					 statement.setInt(1,id);						
					 int result=statement.executeUpdate();
					 if(result>0)
					 {
						 System.out.println("hoca silindi");
						 return true;
					 }
					 else
					 { 
						 return false;
					 }
				}
				catch (Exception e) { 
					System.out.println("Hata:"+e.getMessage()); 
					return false;
				}
			}
//hoca bilgi guncelle
			public boolean hocaguncelle(VeriBilgileri hoca,int id)
			{
		        String HocaMail=hoca.getHocaMail();
		        String HocaSifre=hoca.getHocaSifre();	
		        String HocaTarih=hoca.getHocaTarih();	
				
				try
				{
					
					CallableStatement statement=(CallableStatement) con.prepareCall("{call hocaguncelle(?,?,?,?)}");
					 statement.setInt(1,id);
					 statement.setString(2,HocaMail);	
					 statement.setString(3,HocaSifre);	
					 statement.setString(4,HocaTarih);	
					 int result=statement.executeUpdate();
					 if(result>0)
					 {
						 System.out.println("hoca bilgileri Güncellendi");
						 return true;
					 }
					 else
					 { 
						 return false;
					 }
				}
				catch (Exception e) { 
					System.out.println("Hata:"+e.getMessage()); 
					return false;
				}
			}
			
//MAKALE ÝÞLEMLERÝ			
//***Makale Listeleme
	public ResultSet makalelistesi()
	{		
		try
		{
			        CallableStatement stm=(CallableStatement) con.prepareCall("{call makalelistesi()}");
					boolean hasResult =stm.execute();
					if(hasResult){
					ResultSet res=stm.getResultSet();
					System.out.println("Listeleme Baþarýlý");
					return res;
					}
					else 
					   return null;
					}
		catch (Exception e) 
		{ 
			System.out.println("Hata:"+e.getMessage());	
		}
		return resultSet;
	}
//*** makale selectall
	public ResultSet makaleselectall()
	{		
		try
		{
			        CallableStatement stm=(CallableStatement) con.prepareCall("{call makaleselectall()}");
					boolean hasResult =stm.execute();
					if(hasResult){
					ResultSet res=stm.getResultSet();
					System.out.println("Listeleme Baþarýlý");
					return res;
					}
					else 
					   return null;
					}
		catch (Exception e) 
		{ 
			System.out.println("Hata:"+e.getMessage());	
		}
		return resultSet;
	}
//makale selectdata 
	public ResultSet makaleselectdata(int id)
	{		
		try
		{
			        CallableStatement stm=(CallableStatement) con.prepareCall("{call makaleselectdata(?)}");
			        stm.setInt(1, id);
					boolean hasResult =stm.execute();
					if(hasResult){
					ResultSet res=stm.getResultSet();
					System.out.println("Listeleme Baþarýlý");
					return res;
					}
					else 
					   return null;
					}
		catch (Exception e) 
		{ 
			System.out.println("Hata:"+e.getMessage());	
		}
		return resultSet;
	}
//makale ekle
		public boolean makaleekle(VeriBilgileri makale)
		{
			Baslik=makale.getBaslik();
		    Icerik=makale.getIcerik();
		    Tarih=makale.getTarih();
		    Yazari=makale.getYazari();
		    Durum=makale.getDurum();
		    DegerlendirenHoca=makale.getDegerlendirenHoca();
		    KategoriId=makale.getKategoriId();
			try {
			 CallableStatement Cs;
		     Cs=(CallableStatement) con.prepareCall("{call makaleekle(?,?,?,?,?,?,?)}");  
		     Cs.setString(1, Baslik);
		     Cs.setString(2, Icerik);
		     Cs.setString(3, Tarih);
		     Cs.setString(4, Yazari);
		     Cs.setString(5, Durum);
		     Cs.setString(6, DegerlendirenHoca);
		     Cs.setInt(7, KategoriId);
		     Cs.execute();
		     return true;
		     }
			catch(Exception e) {
				System.out.println("Hata:"+e.getMessage());
				return false;
			}
		}
//makale guncelle
		public boolean makaleguncelle(VeriBilgileri makale,int id)
		{
            String Tarih=makale.getTarih();
			String Durum=makale.getDurum();	
			String DegerlendirenHoca=makale.getDegerlendirenHoca();	
			try
			{
				
				CallableStatement statement=(CallableStatement) con.prepareCall("{call makaleguncelle(?,?,?,?)}");
				 statement.setInt(1,id);
				 statement.setString(2,Tarih);	
				 statement.setString(3,Durum);	
				 statement.setString(4,DegerlendirenHoca);
				 int result=statement.executeUpdate();
				 if(result>0)
				 {
					 System.out.println("makaledeki ilgili alanlar Güncellendi");
					 return true;
				 }
				 else
				 { 
					 return false;
				 }
			}
			catch (Exception e) { 
				System.out.println("Hata:"+e.getMessage()); 
				return false;
			}
		}
//makaleara
		public ResultSet kategoriara(String Baslik)
		{		
			try
			{
				        CallableStatement stm=(CallableStatement) con.prepareCall("{call kategoriara(?)}");
				        stm.setString(1, Baslik);
						boolean hasResult =stm.execute();
						if(hasResult){
						ResultSet res=stm.getResultSet();
						System.out.println("Aramaya Göre Listeleme Baþarýlý");
						return res;
						}
						else 
						   return null;
						}
			catch (Exception e) 
			{ 
				System.out.println("Hata:"+e.getMessage());	
			}
			return resultSet;
		}
//yazar makale güncelleme
		public boolean yazarmakaleguncelle(VeriBilgileri makale,int id)
		{
			String Baslik=makale.getBaslik();	
		    String Icerik=makale.getIcerik();	
            String Tarih=makale.getTarih();
			
			try
			{
				
				CallableStatement statement=(CallableStatement) con.prepareCall("{call yazarmakaleguncelle(?,?,?,?)}");
				 statement.setInt(1,id);
				 statement.setString(2,Baslik);	
				 statement.setString(3,Icerik);	
				 statement.setString(4,Tarih);
				 int result=statement.executeUpdate();
				 if(result>0)
				 {
					 System.out.println("makaledeki ilgili alanlar Güncellendi");
					 return true;
				 }
				 else
				 { 
					 return false;
				 }
			}
			catch (Exception e) { 
				System.out.println("Hata:"+e.getMessage()); 
				return false;
			}
		}
//KATEGORÝ ÝÞLEMLERÝ
//kategori listesi
		public ResultSet kategorilistesi()
		{		
			try
			{
				        CallableStatement stm=(CallableStatement) con.prepareCall("{call kategorilistesi()}");
						boolean hasResult =stm.execute();
						if(hasResult){
						ResultSet res=stm.getResultSet();
						System.out.println("Listeleme Baþarýlý");
						return res;
						}
						else 
						   return null;
						}
			catch (Exception e) 
			{ 
				System.out.println("Hata:"+e.getMessage());	
			}
			return resultSet;
		}
		
		
}

