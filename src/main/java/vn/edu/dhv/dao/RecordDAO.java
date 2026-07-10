package vn.edu.dhv.dao;

import vn.edu.dhv.model.Record;
import vn.edu.dhv.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RecordDAO {
    
    public List<Record> getAllRecords() {
        List<Record> records = new ArrayList<>();
        String query = "SELECT * FROM records";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
             
            while (rs.next()) {
                records.add(new Record(rs.getInt("id"), rs.getString("stname"), rs.getString("course"), rs.getInt("fee")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return records;
    }
    
    public Record getRecordById(int id) {
        String query = "SELECT * FROM records WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
             
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Record(rs.getInt("id"), rs.getString("stname"), rs.getString("course"), rs.getInt("fee"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean insertRecord(Record record) {
        String query = "INSERT INTO records (stname, course, fee) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
             
            ps.setString(1, record.getStname());
            ps.setString(2, record.getCourse());
            ps.setInt(3, record.getFee());
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean updateRecord(Record record) {
        String query = "UPDATE records SET stname = ?, course = ?, fee = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
             
            ps.setString(1, record.getStname());
            ps.setString(2, record.getCourse());
            ps.setInt(3, record.getFee());
            ps.setInt(4, record.getId());
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean deleteRecord(int id) {
        String query = "DELETE FROM records WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
             
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
