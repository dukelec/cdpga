## How to create a new project

### Create QSYS project

Open `Platform Designer` after create an empty Quartus project.

#### Add PCIe IP

First add one `altera_pcie_hard_ip` by `IP_Compiler for PCI Express`:

<img src="img/add_pcie1.png">

 - Change `Number of lanes` to `x1`;
 - Select `62.5 MHz application clock` for low speed grade device: <img src="img/speed_grade.png">
 - Change BAR0 Type to `32 bit Non-Prefetchable`.

<img src="img/add_pcie2.png">

 - Change `Peripheral mode` to `Completer-Only`;
 - Select `Single DW Completer`;
 - Deselect `Control register access (CRA) Avalon slave port`.

#### Add PIO IP

<img src="img/add_pio.png">

#### Connect and export

<img src="img/connect_and_export.png">

Finished:
<img src="img/qsys_finished.png">


### Setup top level

<img src="img/top_level_intf.png">

The transceivers configuration moudle is created and connected externally:
<img src="img/altgx_reconfig.png">

Pin Planner:

<img src="img/pin_planner1.png">

<img src="img/pin_planner2.png">


