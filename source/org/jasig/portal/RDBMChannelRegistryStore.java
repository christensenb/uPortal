/**
 * Copyright � 2001, 2002 The JA-SIG Collaborative.  All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in
 *    the documentation and/or other materials provided with the
 *    distribution.
 *
 * 3. Redistributions of any form whatsoever must retain the following
 *    acknowledgment:
 *    "This product includes software developed by the JA-SIG Collaborative
 *    (http://www.jasig.org/)."
 *
 * THIS SOFTWARE IS PROVIDED BY THE JA-SIG COLLABORATIVE "AS IS" AND ANY
 * EXPRESSED OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE JA-SIG COLLABORATIVE OR
 * ITS CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */

package  org.jasig.portal;

import org.jasig.portal.utils.CounterStoreFactory;
import org.jasig.portal.services.LogService;
import org.jasig.portal.services.GroupService;
import org.jasig.portal.security.IPerson;
import org.jasig.portal.groups.IEntity;
import org.jasig.portal.groups.IEntityGroup;
import org.jasig.portal.groups.IGroupMember;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;

/**
 * Reference implementation of IChannelRegistryStore.
 * @author Ken Weiner, kweiner@interactivebusiness.com
 * @version $Revision$
 */
public class RDBMChannelRegistryStore implements IChannelRegistryStore {

  /**
   * Get a channel definition.
   * @param channelPublishId a channel publish ID
   * @return channelDefinition, a definition of the channel
   * @throws java.sql.SQLException
   */
  public ChannelDefinition getChannelDefinition(int channelPublishId) throws SQLException {
    ChannelDefinition channelDef = null;
    RDBMServices.PreparedStatement pstmtChannel = getChannelPstmt();
    RDBMServices.PreparedStatement pstmtChannelParam = getChannelParamPstmt();

    pstmtChannel.clearParameters();
    pstmtChannel.setInt(1, channelPublishId);
    LogService.instance().log(LogService.DEBUG, "RDBMChannelRegistryStore.getChannelDefinition(): " + pstmtChannel);
    ResultSet rs = pstmtChannel.executeQuery();

    try {
      if (rs.next()) {
        int chanType = rs.getInt(4);
        if (rs.wasNull()) {
          chanType = 0;
        }
        int publisherId = rs.getInt(5);
        if (rs.wasNull()) {
           publisherId = 0;
        }
        int approverId = rs.getInt(6);
        if (rs.wasNull()) {
          approverId = 0;
        }
        int timeout = rs.getInt(9);
        if (rs.wasNull()) {
          timeout = 0;
        }
        channelDef = new ChannelDefinition(channelPublishId, rs.getString(1), rs.getString(2), rs.getString(3),
        chanType, publisherId, approverId, rs.getTimestamp(7), rs.getTimestamp(8), timeout,
          rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13),
          rs.getString(14));

        int dbOffset = 0;
        if (pstmtChannelParam == null) { // we are using a join statement so no need for a new query
          dbOffset = 14;
        } else {
          rs.close();
          pstmtChannelParam.clearParameters();
          pstmtChannelParam.setInt(1, channelPublishId);
          LogService.instance().log(LogService.DEBUG, "RDBMChannelRegistryStore.getChannelDefinition(): " + pstmtChannelParam);
          rs = pstmtChannelParam.executeQuery();
        }

        while (true) {
          if (pstmtChannelParam != null && !rs.next()) {
            break;
          }
          String name = rs.getString(dbOffset + 1);
          String value = rs.getString(dbOffset + 2);
          String override = rs.getString(dbOffset + 3);
          if (name != null) {
            channelDef.addParameter(name, value, override);
          }
          if (pstmtChannelParam == null && !rs.next()) {
            break;
          }
        }
      }
    } finally {
      rs.close();
    }

    LogService.instance().log(LogService.DEBUG,
      "RDBMChannelRegistryStore.getChannelDefinition(): Read channel " + channelPublishId + " from the store");

    return channelDef;
  }

  /**
   * Publishes a channel.
   * @param channelDef the channel definition
   * @param categories the categories of which this channel should be a member
   * @throws java.lang.Exception
   */
  public void addChannelDefinition (ChannelDefinition channelDef, ChannelCategory[] categories) throws Exception {
    Connection con = RDBMServices.getConnection();
    try {
      int channelPublishId = channelDef.getPublishId();

      // Set autocommit false for the connection
      RDBMServices.setAutoCommit(con, false);
      Statement stmt = con.createStatement();
      try {
        String sqlTitle = RDBMServices.sqlEscape(channelDef.getTitle());
        String sqlDescription = RDBMServices.sqlEscape(channelDef.getDescription());
        String sqlClass = channelDef.getJavaClass();
        int sqlTypeID = channelDef.getTypeId();
        int chanPupblUsrId = channelDef.getPublisherId();
        String sysdate = RDBMServices.sqlTimeStamp();
        int sqlTimeout = channelDef.getTimeout();
        String sqlEditable = RDBMServices.dbFlag(channelDef.isEditable());
        String sqlHasHelp = RDBMServices.dbFlag(channelDef.hasHelp());
        String sqlHasAbout = RDBMServices.dbFlag(channelDef.hasAbout());
        String sqlName = RDBMServices.sqlEscape(channelDef.getName());
        String sqlFName = RDBMServices.sqlEscape(channelDef.getFName());

        String query = "SELECT CHAN_ID FROM UP_CHANNEL WHERE CHAN_ID=" + channelPublishId;
        LogService.instance().log(LogService.DEBUG, "RDBMChannelRegistryStore.addChannelDefinition(): " + query);
        ResultSet rs = stmt.executeQuery(query);

        // If channel is already there, do an update, otherwise do an insert
        if (rs.next()) {
          String update = "UPDATE UP_CHANNEL SET " +
          "CHAN_TITLE='" + sqlTitle + "', " +
          "CHAN_DESC='" + sqlDescription + "', " +
          "CHAN_CLASS='" + sqlClass + "', " +
          "CHAN_TYPE_ID=" + sqlTypeID + ", " +
          "CHAN_PUBL_ID=" + chanPupblUsrId + ", " +
          "CHAN_PUBL_DT=" + sysdate + ", " +
          "CHAN_APVL_ID=NULL, " +
          "CHAN_APVL_DT=NULL, " +
          "CHAN_TIMEOUT=" + sqlTimeout + ", " +
          "CHAN_EDITABLE='" + sqlEditable + "', " +
          "CHAN_HAS_HELP='" + sqlHasHelp + "', " +
          "CHAN_HAS_ABOUT='" + sqlHasAbout + "', " +
          "CHAN_NAME='" + sqlName + "', " +
          "CHAN_FNAME='" + sqlFName + "' " +
          "WHERE CHAN_ID=" + channelPublishId;
          LogService.instance().log(LogService.DEBUG, "RDBMChannelRegistryStore.addChannelDefinition(): " + update);
          stmt.executeUpdate(update);
        } else {
          String insert = "INSERT INTO UP_CHANNEL (CHAN_ID, CHAN_TITLE, CHAN_DESC, CHAN_CLASS, CHAN_TYPE_ID, CHAN_PUBL_ID, CHAN_PUBL_DT,  CHAN_TIMEOUT, "
              + "CHAN_EDITABLE, CHAN_HAS_HELP, CHAN_HAS_ABOUT, CHAN_NAME, CHAN_FNAME) ";
          insert += "VALUES (" + channelPublishId + ", '" + sqlTitle + "', '" + sqlDescription + "', '" + sqlClass + "', " + sqlTypeID + ", "
              + chanPupblUsrId + ", " + sysdate + ", " + sqlTimeout
              + ", '" + sqlEditable + "', '" + sqlHasHelp + "', '" + sqlHasAbout
              + "', '" + sqlName + "', '" + sqlFName + "')";
          LogService.instance().log(LogService.DEBUG, "RDBMChannelRegistryStore.addChannelDefinition(): " + insert);
          stmt.executeUpdate(insert);
        }

        // First delete existing parameters for this channel
        String delete = "DELETE FROM UP_CHANNEL_PARAM WHERE CHAN_ID=" + channelPublishId;
        LogService.instance().log(LogService.DEBUG, "RDBMChannelRegistryStore.addChannelDefinition(): " + delete);
        int recordsDeleted = stmt.executeUpdate(delete);

        ChannelDefinition.ChannelParameter[] parameters = channelDef.getParameters();

        if (parameters != null) {
          for (int i = 0; i < parameters.length; i++) {
            String paramName = parameters[i].getName();
            String paramValue = parameters[i].getValue();
            boolean paramOverride = parameters[i].getOverride();

            if (paramName == null && paramValue == null) {
              throw new RuntimeException("Invalid parameter node");
            }

            String insert = "INSERT INTO UP_CHANNEL_PARAM (CHAN_ID, CHAN_PARM_NM, CHAN_PARM_VAL, CHAN_PARM_OVRD) VALUES (" + channelPublishId +
                ",'" + paramName + "','" + paramValue + "', '" + (paramOverride ? "Y" : "N") + "')";
            LogService.instance().log(LogService.DEBUG, "RDBMChannelRegistryStore.addChannelDefinition(): " + insert);
            stmt.executeUpdate(insert);
          }
        }

        // Commit the transaction
        RDBMServices.commit(con);
      } catch (SQLException sqle) {
        RDBMServices.rollback(con);
        throw  sqle;
      } finally {
        stmt.close();
      }

      // Save channel categories memberships

      // First delete existing category memberships for this channel
      String channelDefEntityKey = String.valueOf(channelDef.getPublishId());
      IEntity channelDefEntity = GroupService.getEntity(channelDefEntityKey, ChannelDefinition.class);
      IEntityGroup topLevelCategory = GroupService.getDistinguishedGroup(GroupService.CHANNEL_CATEGORIES);
      Iterator iter = topLevelCategory.getAllMembers();
      while (iter.hasNext()) {
        IGroupMember groupMember = (IGroupMember)iter.next();
        if (groupMember.isGroup()) {
          IEntityGroup group = (IEntityGroup)groupMember;
          group.removeMember(channelDefEntity);
          group.updateMembers();
        }
      }

      // Then insert new category memberships
      for (int i = 0; i < categories.length; i++) {
        categories[i].addChannelDefinition(channelDef);
      }

    } finally {
      RDBMServices.releaseConnection(con);
    }
  }

  /**
   * Permanently deletes a channel definition from the store.
   * @param channelPublishId a channel publish ID
   * @throws java.sql.SQLException
   */
  public void deleteChannelDefinition(int channelPublishId) throws SQLException {
    throw new SQLException("not implemented yet");
  }

  /**
   * Sets a channel definition as "approved".  This effectively makes a
   * channel definition available in the channel registry, making the channel
   * available for subscription.
   * @param channelPublishId a channel publish ID
   * @param approver the user that approves this channel definition
   * @param approveDate the date when the channel definition should be approved (can be future dated)
   * @throws java.sql.SQLException
   */
  public void approveChannelDefinition(int channelPublishId, IPerson approver, Date approveDate) throws SQLException {
   Connection con = RDBMServices.getConnection();
    try {
      Statement stmt = con.createStatement();
      try {
        String update = "UPDATE UP_CHANNEL SET CHAN_APVL_ID = " + approver.getID() +
        ", CHAN_APVL_DT = " + RDBMServices.sqlTimeStamp(approveDate) +
        " WHERE CHAN_ID = " + channelPublishId;
        LogService.instance().log(LogService.DEBUG, "RDBMChannelRegistryStore.approveChannel(): " + update);
        stmt.executeUpdate(update);
      } finally {
        stmt.close();
      }
    } finally {
      RDBMServices.releaseConnection(con);
    }
  }


  /**
   * Removes a channel from the channel registry by changing
   * its status from "approved" to "unapproved".  Afterwards, no one
   * will be able to subscribe to or render the channel.
   * @param channelPublishId, the ID of the channel definition to disapprove
   * @throws java.sql.SQLException
   */
  public void disapproveChannelDefinition (String channelPublishId) throws SQLException {
    Connection con = RDBMServices.getConnection();
    try {
      // Set autocommit false for the connection
      RDBMServices.setAutoCommit(con, false);
      Statement stmt = con.createStatement();
      try {
        // Delete channel.
        String update = "UPDATE UP_CHANNEL SET CHAN_APVL_DT=NULL WHERE CHAN_ID=" + channelPublishId;
        LogService.instance().log(LogService.DEBUG, "RDBMChannelRegistryStore.disapproveChannelDefinition(): " + update);
        stmt.executeUpdate(update);

        // Commit the transaction
        RDBMServices.commit(con);
      } catch (SQLException sqle) {
        // Roll back the transaction
        RDBMServices.rollback(con);
        throw sqle;
      } finally {
          stmt.close();
      }
    } finally {
      RDBMServices.releaseConnection(con);
    }
  }

  /**
   * Get channel types.
   * @return types, the channel types as a Document
   * @throws java.sql.SQLException
   */
  public ChannelType[] getChannelTypes() throws SQLException {
    ChannelType[] channelTypes = null;
    Connection con = RDBMServices.getConnection();

    try {
      Statement stmt = con.createStatement();
      try {
        String query = "SELECT TYPE_ID, TYPE, TYPE_NAME, TYPE_DESCR, TYPE_DEF_URI FROM UP_CHAN_TYPE";
        LogService.instance().log(LogService.DEBUG, "RDBMChannelRegistryStore.getChannelTypes(): " + query);
        ResultSet rs = stmt.executeQuery(query);
        try {
          List channelTypesList = new ArrayList();
          while (rs.next()) {
            int channelTypeId = rs.getInt(1);
            String javaClass = rs.getString(2);
            String name = rs.getString(3);
            String descr = rs.getString(4);
            String cpdUri = rs.getString(5);

            ChannelType channelType = new ChannelType(channelTypeId, javaClass, name, descr, cpdUri);
            channelTypesList.add(channelType);
          }
          channelTypes = (ChannelType[])channelTypesList.toArray(new ChannelType[0]);
        } finally {
          rs.close();
        }
      } finally {
        stmt.close();
      }
    } finally {
      RDBMServices.releaseConnection(con);
    }
    return channelTypes;
  }

  /**
   * Registers a new channel type.
   * @param chanType a channel type
   * @throws java.sql.SQLException
   */
  public void addChannelType (ChannelType chanType) throws SQLException {
    Connection con = null;

    try {
      int nextID = CounterStoreFactory.getCounterStoreImpl().getIncrementIntegerId("UP_CHAN_TYPE");
      String javaClass = chanType.getJavaClass();
      String name = chanType.getName();
      String descr = chanType.getDescription();
      String cpdUri = chanType.getCpdUri();

      con = RDBMServices.getConnection();

      // Set autocommit false for the connection
      RDBMServices.setAutoCommit(con, false);
      Statement stmt = con.createStatement();
      try {
        // Insert channel type.
        String insert = "INSERT INTO UP_CHAN_TYPE VALUES (" +
         "'" + nextID + "', " +
         "'" + javaClass + "', " +
         "'" + name + "', " +
         "'" + descr + "', " +
         "'" + cpdUri + "')";
        LogService.instance().log(LogService.DEBUG, "RDBMChannelRegistryStore.addChannelType(): " + insert);
        int rows = stmt.executeUpdate(insert);

        // Commit the transaction
        RDBMServices.commit(con);
      } catch (SQLException sqle) {
        // Roll back the transaction
        RDBMServices.rollback(con);
        throw sqle;
      } finally {
          stmt.close();
      }
    } catch (Exception e) {
      throw new SQLException(e.getMessage());
    } finally {
      RDBMServices.releaseConnection(con);
    }
  }

  protected static final RDBMServices.PreparedStatement getChannelPstmt() throws SQLException {
    String sql = "SELECT UC.CHAN_TITLE, UC.CHAN_DESC, UC.CHAN_CLASS, UC.CHAN_TYPE_ID, " +
                 "UC.CHAN_PUBL_ID, UC.CHAN_APVL_ID, UC.CHAN_PUBL_DT, UC.CHAN_APVL_DT, " +
                 "UC.CHAN_TIMEOUT, UC.CHAN_EDITABLE, UC.CHAN_HAS_HELP, UC.CHAN_HAS_ABOUT, " +
                 "UC.CHAN_NAME, UC.CHAN_FNAME";

    if (RDBMServices.supportsOuterJoins) {
      sql += ", CHAN_PARM_NM, CHAN_PARM_VAL, CHAN_PARM_OVRD, CHAN_PARM_DESC FROM " + RDBMServices.joinQuery.getQuery("channel");
    } else {
      sql += " FROM UP_CHANNEL UC WHERE";
    }

    sql += " UC.CHAN_ID=? AND CHAN_APVL_DT IS NOT NULL AND CHAN_APVL_DT <= " + RDBMServices.sqlTimeStamp();

    return new RDBMServices.PreparedStatement(RDBMServices.getConnection(), sql);
  }

  protected static final RDBMServices.PreparedStatement getChannelParamPstmt() throws SQLException {
    if (RDBMServices.supportsOuterJoins) {
      return null;
    } else {
      return new RDBMServices.PreparedStatement(RDBMServices.getConnection(), "SELECT CHAN_PARM_NM, CHAN_PARM_VAL,CHAN_PARM_OVRD,CHAN_PARM_DESC FROM UP_CHANNEL_PARAM WHERE CHAN_ID=?");
    }
  }
}
