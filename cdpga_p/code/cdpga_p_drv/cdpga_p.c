/*
 * Software License Agreement (GPL License)
 *
 * Copyright (c) 2018, DUKELEC, Inc.
 * All rights reserved.
 *
 * Author: Duke Fong <d@d-l.io>
 */

#define DEBUG

#include <linux/fs.h>
#include <linux/cdev.h>
#include <linux/module.h>
#include <linux/pci.h>

#define DRV_NAME "cdpga_p"
#define BAR_NUM 1

typedef struct {
    struct pci_dev  *dev;
	void __iomem    *bar_va[BAR_NUM];
} cdp_t;


static int cdp_probe(struct pci_dev *dev, const struct pci_device_id *id)
{
    int ret, bar = 0;
    cdp_t *cdp;

    dev_dbg(&dev->dev, " %s\n", __FUNCTION__);

    ret = pci_enable_device(dev);
    if (ret) {
        dev_err(&dev->dev, "pci_enable_device err: %d!\n", ret);
        return ret;
    }

	cdp = kzalloc(sizeof(cdp_t), GFP_KERNEL);
	if (!cdp) {
		ret = -ENOMEM;
		goto err_alloc;
	}
	
    cdp->dev = dev;
    pci_set_drvdata(dev, cdp);

    ret = pci_enable_msi(dev);
    if (ret) {
        dev_err(&dev->dev, "pci_enable_msi err: %d!\n", ret);
        goto err_msi;
    }

    ret = pci_request_regions(dev, DRV_NAME);
    if (ret) {
        dev_err(&dev->dev, "pci_request_regions err: %d!\n", ret);
        goto err_regions;
    }

    cdp->bar_va[bar] = pci_iomap(dev, bar, 0);
    if (!cdp->bar_va[bar]) {
        dev_err(&dev->dev, "pci_iomap err!\n");
        ret = -1;
        goto err_map;
    }

    dev_dbg(&dev->dev, "cdp_probe successful\n");

    {
        uint32_t *reg_dir = cdp->bar_va[bar] + 4;

        dev_dbg(&dev->dev, "%p: %08x\n", reg_dir, *reg_dir);
        *reg_dir = 0xffff;
        dev_dbg(&dev->dev, "%p: %08x\n", reg_dir, *reg_dir);
    }

    return 0;

err_map:
    pci_release_regions(dev);
err_regions:
    pci_disable_msi(dev);
err_msi:
    kfree(cdp);
    pci_set_drvdata(dev, NULL);
err_alloc:
    pci_disable_device(dev);

    return ret;
}

static void cdp_remove(struct pci_dev *dev)
{
    int bar = 0;
    cdp_t *cdp = pci_get_drvdata(dev);

    dev_dbg(&dev->dev, " %s\n", __FUNCTION__);

    if (cdp->bar_va[bar]) {
        pci_iounmap(dev, cdp->bar_va[bar]);
        cdp->bar_va[bar] = NULL;
    }

    pci_release_regions(dev);
    pci_disable_msi(dev);
    pci_set_drvdata(dev, NULL);
    pci_disable_device(dev);
}


static const struct pci_device_id ids[] = {
    { PCI_DEVICE(0x1172, 0x0004), },
    { 0, }
};
MODULE_DEVICE_TABLE(pci, ids);

static struct pci_driver cdp_driver = {
    .name = DRV_NAME,
    .id_table = ids,
    .probe = cdp_probe,
    .remove = cdp_remove
};

static int __init cdp_init(void)
{
    int ret;
    pr_debug(DRV_NAME " %s\n", __FUNCTION__);

    ret = pci_register_driver(&cdp_driver);
    if (ret < 0)
        return ret;
    return 0;
}

static void __exit cdp_exit(void)
{
    pr_debug(DRV_NAME " %s\n", __FUNCTION__);
    pci_unregister_driver(&cdp_driver);
}

MODULE_LICENSE("GPL");
module_init(cdp_init);
module_exit(cdp_exit);
