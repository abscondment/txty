package org.threebrothers.brendan.txty

import android.app.Activity

class TxtyActivity < Activity
  def onCreate(state)
    super state
    setContentView R.layout.main
  end
end
