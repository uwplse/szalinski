#include <CGAL/Exact_predicates_inexact_constructions_kernel.h>
#include <CGAL/Polyhedron_items_with_id_3.h>
#include <CGAL/Polyhedron_3.h>
#include <CGAL/Surface_mesh.h>
#include <CGAL/Polygon_mesh_processing/corefinement.h>
#include <CGAL/Polygon_mesh_processing/distance.h>
#include <CGAL/Polygon_mesh_processing/remesh.h>

#include <CGAL/IO/OFF_reader.h>
#include <math.h>

#if defined(CGAL_LINKED_WITH_TBB)
#define TAG CGAL::Parallel_tag
#else
#define TAG CGAL::Sequential_tag
#endif

typedef CGAL::Exact_predicates_inexact_constructions_kernel K;
typedef CGAL::Polyhedron_3<K, CGAL::Polyhedron_items_with_id_3>  Polyhedron;
typedef K::Point_3                     Point;
typedef CGAL::Surface_mesh<K::Point_3> Mesh;

namespace PMP = CGAL::Polygon_mesh_processing;

int main(int argc, char* argv[])
{
  if (argc < 3) {
    std::cerr << "Needs two meshes, -v for volume, -h for haussdorf" << std::endl;
    return 1;
  }

  const char* f1  = argv[1];
  const char* f2  = argv[2];
  const char* f3  = argv[3];

  Mesh tm1, tm2;
  std::ifstream i1(f1);
  i1 >> tm1;
  std::ifstream i2(f2);
  i2 >> tm2;


  if(!i1 || !i2)
  {
    std::cerr << "Cannot open files " << std::endl;
    return EXIT_FAILURE;
  }

  if (strcmp(f3, "-v") == 0) {
    Mesh diff;
    CGAL::Polygon_mesh_processing::corefine_and_compute_difference(tm1, tm2, diff);
    double v1 = CGAL::Polygon_mesh_processing::volume(tm1);
    double v2 = CGAL::Polygon_mesh_processing::volume(tm2);
    double v_diff = CGAL::Polygon_mesh_processing::volume(diff);
    double normalized_v_diff = v_diff / std::max(v1, v2);
    std::cout<<normalized_v_diff<<std::endl;

  } else if (strcmp(f3, "-h") == 0) {
    if (argc < 5) {
      std::cout << "Pass a number after h" << std::endl;
      exit(1);
    }
    int n = std::stoi(argv[4]);
    CGAL::Bbox_3 bb1 = CGAL::Polygon_mesh_processing::bbox(tm1);
    CGAL::Bbox_3 bb2 = CGAL::Polygon_mesh_processing::bbox(tm2);
    double bb1_xmin = bb1.xmin();
    double bb1_ymin = bb1.ymin();
    double bb1_zmin = bb1.zmin();
    double bb2_xmin = bb2.xmin();
    double bb2_ymin = bb2.ymin();
    double bb2_zmin = bb2.zmin();
    double bb1_xmax = bb1.xmax();
    double bb1_ymax = bb1.ymax();
    double bb1_zmax = bb1.zmax();
    double bb2_xmax = bb2.xmax();
    double bb2_ymax = bb2.ymax();
    double bb2_zmax = bb2.zmax();
    double d1 = sqrt(pow((bb1_xmax - bb1_xmin), 2) + pow((bb1_ymax - bb1_ymin), 2) + pow((bb1_zmax - bb1_zmin), 2));
    double d2 = sqrt(pow((bb2_xmax - bb2_xmin), 2) + pow((bb2_ymax - bb2_ymin), 2) + pow((bb2_zmax - bb2_zmin), 2));
    double bb_diag = std::max(d1, d2);
    double d = CGAL::Polygon_mesh_processing::approximate_Hausdorff_distance<TAG>
      (tm1,
       tm2,
       PMP::parameters::number_of_points_on_edges(n),
       PMP::parameters::number_of_points_on_faces(n)
       );
    double normalized_d = d / bb_diag;
    std::cout << normalized_d << std::endl;
  } else {
    std::cout << "Invalid arg" << std::endl;
    exit(1);
  }
}
