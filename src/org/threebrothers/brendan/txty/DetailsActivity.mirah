package org.threebrothers.brendan.txty

import android.app.Activity
import android.os.Bundle
import android.util.Log

import android.content.res.Configuration

class DetailsActivity < Activity
  $Override
  def onCreate(state:Bundle)
    super state

    if getResources.getConfiguration.orientation == Configuration.ORIENTATION_LANDSCAPE
      # // If the screen is now in landscape mode, we can show the
      # // dialog in-line so we don't need this activity.
      finish
      return
    end

    if state.nil?
      # // During initial setup, plug in the details fragment.
      details = DetailsFragment.new
      details.setArguments(getIntent.getExtras)
      getFragmentManager.beginTransaction.add(android::R.id.content, details).commit
    end
  end
end
