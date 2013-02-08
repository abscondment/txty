package org.threebrothers.brendan.txty

import android.app.FragmentTransaction
import android.app.ListFragment
import android.app.LoaderManager
import android.app.LoaderManager.LoaderCallbacks
import android.content.CursorLoader
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.view.View
import android.widget.AbsListView
import android.widget.ListView
import android.widget.SimpleAdapter

import android.util.Log

class SmsFragment < ListFragment
  $Override
  def onActivityCreated(state:Bundle)
    super state

    # Set up our adapter
    data = [{"name" => "Test"}, {"name" => "It works!"}]
    from = String[1]
    from[0] = "name"
    to = int[1]
    to[0] = R.id.name
    adapter = SimpleAdapter.new(getActivity, data, R.layout.list_item, from, to)
    setListAdapter(adapter)

    details = getActivity.findViewById(R.id.details)
    @is_dual_pane = (!details.nil?) && details.getVisibility == View.VISIBLE

    @check_position = 0
    unless state.nil?
      # Restore last state for checked position.
      @check_position = state.getInt("curChoice", 0)
    end

    if @is_dual_pane
      # In dual-pane mode, list view highlights selected item.
      getListView.setChoiceMode(AbsListView.CHOICE_MODE_SINGLE)
      # Make sure our UI is in the correct state.
      showDetails @check_position
    end
  end

  $Override
  def onSaveInstanceState(state:Bundle):void
    super state
    state.putInt("curChoice", @check_position)
  end

  $Override
  def onListItemClick(list:ListView, view:View, pos:int, id:long):void
    showDetails pos
  end

  def showDetails(index:int):void
    @check_position = index
    if @is_dual_pane
      # // We can display everything in-place with fragments.
      # // Have the list highlight this item and show the data.
      getListView.setItemChecked(index, true)

      # // Check what fragment is shown, replace if needed.
      details = DetailsFragment(getFragmentManager.findFragmentById R.id.details)

      if details.nil? || details.getShownIndex != index
        # // Make new fragment to show this selection.
        details = DetailsFragment.newInstance(index)
      end

      # // Execute a transaction, replacing any existing
      # // fragment with this one inside the frame.
      ft = getFragmentManager.beginTransaction
      ft.replace(R.id.details, details)
      ft.setTransition(FragmentTransaction.TRANSIT_FRAGMENT_FADE)
      ft.commit

    else
      # // Otherwise we need to launch a new activity to display
      # // the dialog fragment with selected text.
      intent = Intent.new
      intent.setClass(getActivity, DetailsActivity.class);
      intent.putExtra("index", index)
      startActivity(intent)
    end
  end

  protected

  # $Override
  # def onStart:void
  #   super

  #   read_sms
  # end

  def read_sms:void
    sms_query_uri = Uri.parse("content://sms")
    args = String[7]
    args[0] = "_id"
    args[1] = "thread_id"
    args[2] = "address"
    args[3] = "person"
    args[4] = "date"
    args[5] = "body"
    args[6] = "type"
    cursor = getActivity.getContentResolver.query(sms_query_uri, args, nil, nil, nil)


    # # startManagingCursor(cursor1);
    #     columns = String[5]
    #     columns[0] = "address"
    #     columns[1] = "person"
    #     columns[2] = "date"
    #     columns[3] = "body"
    #     columns[4] = "type"
    
    # if (cursor1.getCount() > 0) {
    #     String count = Integer.toString(cursor1.getCount());
    #     Log.e("Count",count);
    #     while (cursor1.moveToNext()) {
    #         out.write("<message>");
    #         String address = cursor1.getString(cursor1
    #                 .getColumnIndex(columns[0]));
    #         String name = cursor1.getString(cursor1
    #                 .getColumnIndex(columns[1]));
    #         String date = cursor1.getString(cursor1
    #                 .getColumnIndex(columns[2]));
    #         String msg = cursor1.getString(cursor1
    #                 .getColumnIndex(columns[3]));
    #         String type = cursor1.getString(cursor1
    #                 .getColumnIndex(columns[4]));
    # } }
  end
end
