import java.sql.* ;
import java.util.*;


class Connect{
	static Connection con ;
	public static void connect(String url , String uname , String pass) throws Exception {
		con = DriverManager.getConnection(url, uname, pass);
	}
}

class Student{
	public static void login(String name , String password)throws Exception {
		String query = "select * from student where name='"+name+"' and password='"+password+"'";
		Statement st = Connect.con.createStatement();
		ResultSet rs = st.executeQuery(query);
		Scanner in = new Scanner(System.in);
		if(rs.next()) {
			int userid = rs.getInt(1);
			System.out.println("1.) Register complaint\n2.) Give Mess feedback");
			int option = in.nextInt();
			if(option == 1) {
				System.out.println("Choose complaint\n1.) Electricity\n2.) Water\n3.) Furniture");
				String complaint = in.next();
				System.out.println("Give some description : ");
				in.nextLine();
				String description = in.nextLine();
				int roomid = rs.getInt(4);
				RoomMaintenance.lodgecomplaint(complaint , userid , description , roomid);
			}
			else if(option == 2) {
				int roomid = rs.getInt(3);
				System.out.println("Rate from 1 to 5 the following\n");
				Mess.feedback(userid,roomid);
			}
		}
		else {
			System.out.println("Account with this username and password does not exist./nWant to create a new account . Press Y for Yes and N for No");
			char choice = in.next().charAt(0);
			if(choice == 'Y') {
				System.out.println("Provide username and password");
				name = in.next();
				password = in.next();
				newAccount(name,password);
			}
		}
		in.close();
		
	}
	public static void newAccount(String name , String password) throws Exception{
		String query = "insert into student values (?,?,?,?,?,?)";
		PreparedStatement pst = Connect.con.prepareStatement(query);
		System.out.println("Enter studentId , phone , messId and roomid");
		Scanner in = new Scanner(System.in);
		int studentid = in.nextInt();
		String phone = in.next();
		int messid = in.nextInt();
		int roomid = in.nextInt();
		pst.setInt(1,studentid);
		pst.setString(2,phone);
		pst.setInt(3,messid);
		pst.setInt(4,roomid);
		pst.setString(5,name);
		pst.setString(6,password);
		pst.executeUpdate();
		System.out.println("New Account created.");
	}
}

class RoomMaintenance{
	public static void lodgecomplaint(String complaint , int userid , String description , int roomid) throws Exception{
		String query = "insert into roommaintenance values (?,?,?,?)";
		PreparedStatement pst = Connect.con.prepareStatement(query);
		pst.setInt(1,userid);
		pst.setString(2,complaint);
		pst.setString(3,description);
		pst.setInt(4,roomid);
		pst.executeUpdate();
		System.out.println("Your complaint has been lodged");
	}
}

class Mess{
	public static void feedback(int userid , int messid) throws Exception{
		Scanner in = new Scanner(System.in);
		System.out.printf("Hygiene : ");
		int hygiene = in.nextInt();
		System.out.printf("Quality : ");
		int quality = in.nextInt();
		System.out.printf("Taste : ");
		int taste = in.nextInt();
		String query = "insert into messfeedback values (?,?,?,?,?)";
		PreparedStatement pst = Connect.con.prepareStatement(query);
		
		pst.setInt(1,messid);
		pst.setInt(2,hygiene);
		pst.setInt(3,quality);
		pst.setInt(4,taste);
		pst.setInt(5,userid);
		pst.executeUpdate();
		System.out.println("You have successfully given your feedback . Thank You");
		in.close();
	}
}

public class HostelManagement {
	public static void main(String[] args) throws Exception {
		Scanner in = new Scanner(System.in);
		String url = "jdbc:mysql://localhost:3306/hostel?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDateTimeCode=false&serverTimezone=UTC";
		String uname = "root";
		String pass = "";
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connect.connect(url, uname, pass);
		System.out.println("Already have a account.Press Y for Yes and N for No.");
		char choice = in.next().charAt(0);
		if(choice == 'Y') {
			System.out.println("Enter userid and password to login");
			String name = in.next();
			String password = in.next();
			Student.login(name , password);
		}
		else {
			System.out.println("Provide username and password");
			String name = in.next();
			String password = in.next();
			Student.newAccount(name , password);
		}
		in.close();
	}

}
