# ABAP List Viewer with MVC Concept
## Framework architecture
The framework consists of the following repo objects:
  1. The main controller class ZCL_MVCFW_BASE_CONTROLLER. A program will define its own main controller inheriting from this class.
  2. The dynpro class ZCL_MVCFW_BASE_VIEW. A program was called by function module REUSE_ALV_GRID_DISPLAY_LVC.
  3. The model class ZCL_MVCFW_BASE_MODEL. This class will be rerieved any data for display result to ALV. 
  4. The screen class ZCL_MVCFW_BASE_SSCR. It will manipulate selection screen that handle via PBO and PAI.  

## Demo application

The report YDEMO_APP_V2 is a simple application with a simple dynpro and two ALV grids in it.

![image](https://user-images.githubusercontent.com/57941447/200183813-4b2f9699-4a11-494a-9dd1-7c0e754c7304.png)
