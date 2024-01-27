# Timing 


A small-ish timing library that is particularly useful when trying to time how long multiple runs of the same function take during loops. 
Based on `isaac_ros_nvblox/timing`: https://github.com/nvidia-isaac/nvblox/blob/7c76f90749aa26b89faeca2044fbdcabd910d0a6/nvblox/include/nvblox/utils/timing.h


## Setup (Standalone)
Build and install this library
```
git clone <url>
cd timing
mkdir build
cd build
cmake ..
sudo make install
```

## Setup (ROS)
Simply clone this repo to somewhere in your `colcon_ws/src`. 
Then, in the project that you want to use this library in, add the following lines to the `CMakeLists.txt`
```
...

find_package(timing REQUIRED)


add_executable( ... ) 
target_link_libraries( ...
   ${timing_LIBRARIES}
)
target_include_directories( ...
   ${timing_INCLUDE_DIRS}
)

```


## Usage

The simple usage is pretty straightforward, see `test/test_timing.cpp`. 

In the header, add the line
```
#include "timing/timing.h"
```

Whenever you want to start a timer, 
```
timing::Timer myTimer("group/tag");
```
and when the object is destroyed, the timing will stop. You can also call `myTimer.Stop()` to stop the timer on demand. The `group/tag` system is used to define `group`s that accumulate multiple sub timers, and each `tag` can be used to break down the timing even furter. This means the string you use can be `ros/io/get_image` or `core/optimization` and that will help you break down the timing as desired.
 

To print/return the timing statistics, call
```
timing::Timing::Print(std::cout);
```
to print the timing to `std::cout`.

Alternatively, you can get the result as a `std::string` so you can pass it into a logging tool of choice. For example, to use it in `ros2`, simply call the print inside a throttled stream:
```
// print statistics every 10 seconds
constexpr int kPublishPeriodMs = 10000;
auto & clk = *get_clock();
RCLCPP_INFO_STREAM_THROTTLE(
  get_logger(), clk, kPublishPeriodMs,
  "Timing statistics: \n" << timing::Timing::Print());
```


## Advanced Usage

See `include/timing.h` for all available interfaces. 

If you want to create a timer without starting it immediately, run
```
timing::Timer myTimer("group/tag", false);
```

and then to start and stop the timers manually, run
```
myTimer.Start();
myTimer.Stop();
```


## Disable All timers

So far we have been using ```timing::Timer```. If instead we use ```timing::DummyTimer``` all timing will be disabled.  You could use `typedef` to accomplish this, or find-and-replace.
