package org.threebrothers.brendan.txty

import android.app.Fragment
import android.os.Bundle

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import android.widget.ScrollView
import android.util.TypedValue

import android.util.Log

class DetailsFragment < Fragment
  def self.newInstance(index:int):DetailsFragment
    f = DetailsFragment.new
    # // Supply index input as an argument.
    args = Bundle.new
    args.putInt("index", index)
    f.setArguments(args)
    return f
  end

  def getShownIndex:int
    getArguments.getInt("index", 0)
  end
    
  $Override
   def onCreateView(inflater:LayoutInflater, container:ViewGroup, state:Bundle):View
     if container.nil?
       # // Currently in a layout without a container, so no
       # // reason to create our view.
       return View(nil)
     end

     scroller =  ScrollView.new(getActivity)
     text =  TextView.new(getActivity)
     p = int(TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP,
                                             4,
                                             getActivity.getResources.getDisplayMetrics))
     text.setPadding p, p, p, p
     scroller.addView text

     text.setText "TODO: index #{getShownIndex}"
     # text.setText(Shakespeare.DIALOGUE[getShownIndex()]);
     return scroller
   end
end
