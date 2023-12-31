import React, { useState, useEffect } from "react";
import DashboardHeader from "../../components/DashboardHeader";
import { calculateRange, sliceData } from "../../utils/table-pagination";
import { fetchSiteManagersData } from "../../firebaseServices/firebaseServices";
import "../styles.css";

function SiteManagers() {
  const [search, setSearch] = useState("");
  const [siteManagers, setSiteManagers] = useState([]);
  const [page, setPage] = useState(1);
  const [pagination, setPagination] = useState([]);

  useEffect(() => {
    fetchData();
  }, [page]);

  const fetchData = async () => {
    try {
      const siteManagersData = await fetchSiteManagersData();
      setSiteManagers(siteManagersData);

      setPagination(calculateRange(siteManagersData, 5));
      setSiteManagers(sliceData(siteManagersData, page, 5));
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  };

  const handleSearch = (event) => {
    setSearch(event.target.value);
    if (event.target.value === "") {
      fetchData(); // Reset the data if the search input is empty
    } else {
      const searchResults = siteManagers.filter(
        (item) =>
          item.managerName.toLowerCase().includes(search.toLowerCase()) ||
          item.email.toLowerCase().includes(search.toLowerCase()) ||
          item.contact.toLowerCase().includes(search.toLowerCase()) ||
          item.siteName.toLowerCase().includes(search.toLowerCase()) ||
          item.siteNumber.toLowerCase().includes(search.toLowerCase())
      );
      setSiteManagers(searchResults);
    }
  };

  const handleChangePage = (new_page) => {
    setPage(new_page);
    setSiteManagers(sliceData(siteManagers, new_page, 5));
  };

  return (
    <div className="dashboard-content">
      <DashboardHeader btnText="New Site Manager" />

      <div className="dashboard-content-container">
        <div className="dashboard-content-header">
          <h2>Site Managers List</h2>
          <div className="dashboard-content-search">
            <input
              type="text"
              value={search}
              placeholder="Search.."
              className="dashboard-content-input"
              onChange={handleSearch}
            />
          </div>
        </div>

        <table className="table">
          <thead>
            <tr>
              <th scope="col">Name</th>
              <th scope="col">Email</th>
              <th scope="col">Contact</th>
              <th scope="col">Site Name</th>
              <th scope="col">Site Number</th>
              <th scope="col">Action</th>
            </tr>
          </thead>

          {siteManagers.length !== 0 ? (
            <tbody>
              {siteManagers.map((siteManager, index) => (
                <tr key={index}>
                  <td>{siteManager.managerName}</td>
                  <td>{siteManager.email}</td>
                  <td>{siteManager.contact}</td>
                  <td>{siteManager.siteName}</td>
                  <td>{siteManager.siteNumber}</td>
                  <td>
                    <div>
                      <button className="btn btn-danger btn-sm">Delete</button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          ) : null}
        </table>

        {siteManagers.length !== 0 ? (
          <div className="dashboard-content-footer">
            {pagination.map((item, index) => (
              <span
                key={index}
                className={item === page ? "active-pagination" : "pagination"}
                onClick={() => handleChangePage(item)}
              >
                {item}
              </span>
            ))}
          </div>
        ) : (
          <div className="dashboard-content-footer">
            <span className="empty-table">No data</span>
          </div>
        )}
      </div>
    </div>
  );
}

export default SiteManagers;
