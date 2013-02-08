package org.threebrothers.brendan.txty

import android.app.Activity
import android.os.Bundle
import android.util.Log

class MyTextsActivity < Activity
  $Override
  def onCreate(state:Bundle)
    super state

    setContentView R.layout.main
  end
end
